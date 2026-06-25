import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../domain/entities/review_item.dart';
import '../../domain/entities/review_status.dart';
import '../../application/providers/review_providers.dart';
import '../controllers/review_controller.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/result/app_result.dart';
import '../../../../shared/widgets/review_item_tile.dart';

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(todayReviewItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.reviewAppBarTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: reviewsAsync.when(
        data: (result) {
          if (result is AppSuccess<List<ReviewItem>>) {
            final items = result.data;
            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_stories,
                        size: 64, color: AppColors.primary.withAlpha(128)),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      AppLocalizations.of(context)!.reviewEmptyTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      AppLocalizations.of(context)!.reviewEmptySubtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ReviewItemTile(
                  title: item.title,
                  subject: item.subject,
                  nextReviewDate:
                      '${item.nextReviewAt.month}/${item.nextReviewAt.day}',
                  reviewCount: item.reviewCount,
                  isCompleted: item.status == ReviewStatus.done,
                  onComplete: () {
                    _showConfidenceDialog(context, ref, item);
                  },
                );
              },
            );
          }
          if (result is AppFailure<List<ReviewItem>>) {
            return Center(child: Text('${AppLocalizations.of(context)!.tasksError}${result.error.message}'));
          }
          return const SizedBox.shrink();
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('${AppLocalizations.of(context)!.tasksError}$error')),
      ),
    );
  }

  void _showConfidenceDialog(
      BuildContext context, WidgetRef ref, ReviewItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.reviewConfidenceTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [1, 2, 3, 4, 5]
              .map((level) => ListTile(
                    title: Text(_confidenceLabel(level, ctx)),
                    leading: CircleAvatar(
                      backgroundColor: _confidenceColor(level),
                      child: Text('$level'),
                    ),
                    onTap: () {
                      ref
                          .read(reviewControllerProvider)
                          .completeReview(item, level);
                      Navigator.of(ctx).pop();
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  String _confidenceLabel(int level, BuildContext context) {
    switch (level) {
      case 1:
        return AppLocalizations.of(context)!.reviewConfidenceVeryHard;
      case 2:
        return AppLocalizations.of(context)!.reviewConfidenceHard;
      case 3:
        return AppLocalizations.of(context)!.reviewConfidenceMedium;
      case 4:
        return AppLocalizations.of(context)!.reviewConfidenceEasy;
      case 5:
        return AppLocalizations.of(context)!.reviewConfidenceVeryEasy;
      default:
        return '';
    }
  }

  Color _confidenceColor(int level) {
    switch (level) {
      case 1:
        return AppColors.error;
      case 2:
        return Colors.orange;
      case 3:
        return AppColors.warning;
      case 4:
        return AppColors.info;
      case 5:
        return AppColors.success;
      default:
        return AppColors.primary;
    }
  }
}
