import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../core/result/app_result.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/presentation/controllers/task_controller.dart';
import '../../application/providers/ai_planner_providers.dart';

class QuickTaskInput extends ConsumerStatefulWidget {
  const QuickTaskInput({super.key});

  @override
  ConsumerState<QuickTaskInput> createState() => _QuickTaskInputState();
}

class _QuickTaskInputState extends ConsumerState<QuickTaskInput> {
  final _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _askAi() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _isLoading = true);

    final repo = ref.read(aiPlannerRepositoryProvider);
    final result = await repo.suggestTasksFromText(text);

    if (result is AppSuccess<List<Task>>) {
      final tasks = result.data;
      final taskController = ref.read(taskControllerProvider);
      for (final task in tasks) {
        await taskController.createTask(
          title: task.title,
          subject: task.subject,
          priority: task.priority,
          estimatedMinutes: task.estimatedMinutes,
          createdByAi: true,
        );
      }

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        setState(() => _isLoading = false);
        _controller.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.quickTaskResult(tasks.length.toString()),
            ),
          ),
        );
      }
    } else if (result is AppFailure<List<Task>>) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.error.message)),
        );
      }
    } else {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GlassContainer(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.accent.withAlpha(26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.auto_awesome,
                    color: AppColors.accent, size: 20),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'AI Quick Add',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: l10n.quickTaskHint,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            maxLines: 2,
            onSubmitted: (_) => _askAi(),
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: _isLoading ? null : _askAi,
              icon: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.auto_awesome, size: 18),
              label: Text(l10n.quickTaskAskAi),
            ),
          ),
        ],
      ),
    );
  }
}
