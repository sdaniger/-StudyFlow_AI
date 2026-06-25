import 'package:flutter/material.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'glass_card.dart';

class CalendarEventDraftCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final VoidCallback? onRegister;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  const CalendarEventDraftCard({
    super.key,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.onRegister,
    this.onEdit,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat =
        '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}'
        '${AppLocalizations.of(context)!.calendarTimeSeparator}'
        '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';

    return GlassCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, color: AppColors.primary, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: AppColors.textSecondaryLight),
              const SizedBox(width: AppSpacing.xs),
              Text(
                timeFormat,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (onCancel != null)
                TextButton(
                  onPressed: onCancel,
                  child: Text(AppLocalizations.of(context)!.calendarButtonCancel),
                ),
              if (onEdit != null)
                TextButton(
                  onPressed: onEdit,
                  child: Text(AppLocalizations.of(context)!.calendarButtonEdit),
                ),
              if (onRegister != null)
                ElevatedButton(
                  onPressed: onRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: Text(AppLocalizations.of(context)!.calendarButtonRegister),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
