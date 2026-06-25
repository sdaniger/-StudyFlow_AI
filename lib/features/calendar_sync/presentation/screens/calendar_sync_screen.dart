import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../controllers/calendar_sync_controller.dart';
import '../../domain/entities/calendar_event_draft.dart';
import '../../domain/entities/calendar_sync_result.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/result/app_result.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/primary_action_button.dart';
import '../../../../shared/widgets/calendar_event_draft_card.dart';

class CalendarSyncScreen extends ConsumerStatefulWidget {
  const CalendarSyncScreen({super.key});

  @override
  ConsumerState<CalendarSyncScreen> createState() =>
      _CalendarSyncScreenState();
}

class _CalendarSyncScreenState extends ConsumerState<CalendarSyncScreen> {
  List<CalendarEventDraft>? _drafts;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.calendarAppBarTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassContainer(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(26),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.calendar_month,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.calendarListTileTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          AppLocalizations.of(context)!.calendarListTileSubtitle,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            PrimaryActionButton(
              label: _isLoading
                  ? AppLocalizations.of(context)!.calendarButtonGenerating
                  : AppLocalizations.of(context)!.calendarButtonGenerate,
              icon: Icons.auto_awesome,
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _handleSuggest,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_drafts != null) ...[
              Text(
                AppLocalizations.of(context)!.calendarSectionDrafts,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              if (_drafts!.isEmpty)
                GlassContainer(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(
                        AppLocalizations.of(context)!.calendarEmptyDrafts,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                )
              else
                ...(_drafts!.map((draft) => CalendarEventDraftCard(
                      title: draft.title,
                      description: draft.description ?? '',
                      startTime: draft.startAt,
                      endTime: draft.endAt,
                      onRegister: () => _handleRegister(draft),
                    ))),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _handleSuggest() async {
    setState(() => _isLoading = true);
    final controller = ref.read(calendarSyncControllerProvider);
    final result = await controller.suggestEvents();
    setState(() => _isLoading = false);

    if (result is AppSuccess<List<CalendarEventDraft>>) {
      setState(() => _drafts = result.data);
    } else if (result is AppFailure<List<CalendarEventDraft>>) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.tasksError}${result.error.message}')),
        );
      }
    }
  }

  Future<void> _handleRegister(CalendarEventDraft draft) async {
    final controller = ref.read(calendarSyncControllerProvider);
    final result = await controller.registerEvent(draft);

    if (result is AppSuccess<CalendarSyncResult>) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.calendarEventRegistered)),
        );
      }
    } else if (result is AppFailure<CalendarSyncResult>) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.tasksError}${result.error.message}')),
        );
      }
    }
  }
}
