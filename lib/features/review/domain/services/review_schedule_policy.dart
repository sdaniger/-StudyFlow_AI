import '../entities/review_item.dart';
import '../entities/review_status.dart';

class ReviewSchedulePolicy {
  static const List<int> intervalsDays = [1, 3, 7, 14, 30];

  List<ReviewItem> generateSchedule({
    required String sourceTaskId,
    required String title,
    String? subject,
    required DateTime learnedAt,
    required String Function() generateId,
  }) {
    final now = DateTime.now();
    return intervalsDays.map((days) {
      final nextReview = learnedAt.add(Duration(days: days));
      final reviewCount = intervalsDays.indexOf(days) + 1;
      return ReviewItem(
        id: generateId(),
        sourceTaskId: sourceTaskId,
        title: title,
        subject: subject,
        learnedAt: learnedAt,
        nextReviewAt: nextReview,
        reviewCount: reviewCount,
        status: days == 1 ? ReviewStatus.scheduled : ReviewStatus.scheduled,
        createdAt: now,
        updatedAt: now,
      );
    }).toList();
  }
}
