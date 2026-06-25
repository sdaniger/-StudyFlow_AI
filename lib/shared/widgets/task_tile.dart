import 'package:flutter/material.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'glass_card.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String? subject;
  final String? priority;
  final bool isCompleted;
  final VoidCallback? onTap;
  final VoidCallback? onToggleComplete;
  final VoidCallback? onStepsTap;
  final int stepCount;

  const TaskTile({
    super.key,
    required this.title,
    this.subject,
    this.priority,
    this.isCompleted = false,
    this.onTap,
    this.onToggleComplete,
    this.onStepsTap,
    this.stepCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            onChanged: (_) => onToggleComplete?.call(),
            activeColor: AppColors.success,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                        color: isCompleted
                            ? AppColors.textSecondaryLight
                            : null,
                      ),
                ),
                if (subject != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subject!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
          if (priority != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: _priorityColor(priority!).withAlpha(26),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                priority!,
                style: TextStyle(
                  fontSize: 12,
                  color: _priorityColor(priority!),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          const SizedBox(width: 4),
          if (stepCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(26),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$stepCount',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          const SizedBox(width: 4),
          if (onStepsTap != null)
            IconButton(
              icon: const Icon(Icons.layers_outlined, size: 20),
              onPressed: onStepsTap,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              tooltip: AppLocalizations.of(context)?.smallStepTileTooltip ?? 'Small Steps',
            ),
        ],
      ),
    );
  }

  Color _priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return AppColors.error;
      case 'high':
        return AppColors.warning;
      case 'medium':
        return AppColors.info;
      default:
        return AppColors.success;
    }
  }
}
