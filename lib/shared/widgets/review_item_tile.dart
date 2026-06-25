import 'package:flutter/material.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'glass_card.dart';

class ReviewItemTile extends StatelessWidget {
  final String title;
  final String? subject;
  final String nextReviewDate;
  final int reviewCount;
  final bool isCompleted;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;

  const ReviewItemTile({
    super.key,
    required this.title,
    this.subject,
    required this.nextReviewDate,
    required this.reviewCount,
    this.isCompleted = false,
    this.onTap,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          GestureDetector(
            onTap: onComplete,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.success : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? AppColors.success : AppColors.primary,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    if (subject != null) ...[
                      Text(
                        subject!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Text('·', style: TextStyle(color: AppColors.textSecondaryLight)),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Text(
                      AppLocalizations.of(context)!.reviewItemCount(reviewCount),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            nextReviewDate,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isCompleted ? AppColors.success : AppColors.primary,
                ),
          ),
        ],
      ),
    );
  }
}
