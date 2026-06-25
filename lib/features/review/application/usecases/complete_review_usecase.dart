import '../../domain/entities/review_item.dart';
import '../../domain/entities/review_status.dart';
import '../../domain/repositories/review_repository.dart';
import '../../../../core/result/app_result.dart';

class CompleteReviewUseCase {
  final ReviewRepository _repository;

  CompleteReviewUseCase(this._repository);

  Future<AppResult<ReviewItem>> execute(ReviewItem item, int confidence) {
    final updated = item.copyWith(
      status: ReviewStatus.done,
      confidence: confidence,
      updatedAt: DateTime.now(),
    );
    return _repository.update(updated);
  }
}
