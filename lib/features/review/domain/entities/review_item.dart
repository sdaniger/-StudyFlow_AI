import 'package:equatable/equatable.dart';
import 'review_status.dart';

class ReviewItem extends Equatable {
  final String id;
  final String sourceTaskId;
  final String title;
  final String? subject;
  final DateTime learnedAt;
  final DateTime nextReviewAt;
  final int reviewCount;
  final int confidence;
  final String? accuracy;
  final ReviewStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const ReviewItem({
    required this.id,
    required this.sourceTaskId,
    required this.title,
    this.subject,
    required this.learnedAt,
    required this.nextReviewAt,
    this.reviewCount = 0,
    this.confidence = 0,
    this.accuracy,
    this.status = ReviewStatus.scheduled,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  ReviewItem copyWith({
    String? id,
    String? sourceTaskId,
    String? title,
    String? subject,
    DateTime? learnedAt,
    DateTime? nextReviewAt,
    int? reviewCount,
    int? confidence,
    String? accuracy,
    ReviewStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
  }) {
    return ReviewItem(
      id: id ?? this.id,
      sourceTaskId: sourceTaskId ?? this.sourceTaskId,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      learnedAt: learnedAt ?? this.learnedAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      reviewCount: reviewCount ?? this.reviewCount,
      confidence: confidence ?? this.confidence,
      accuracy: accuracy ?? this.accuracy,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: clearDeletedAt ? null : (deletedAt ?? this.deletedAt),
    );
  }

  @override
  List<Object?> get props => [
        id,
        sourceTaskId,
        title,
        subject,
        learnedAt,
        nextReviewAt,
        reviewCount,
        confidence,
        accuracy,
        status,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
