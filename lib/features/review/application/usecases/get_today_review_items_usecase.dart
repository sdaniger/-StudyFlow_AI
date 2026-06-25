import '../../domain/entities/review_item.dart';
import '../../domain/repositories/review_repository.dart';
import '../../../../core/result/app_result.dart';

class GetTodayReviewItemsUseCase {
  final ReviewRepository _repository;

  GetTodayReviewItemsUseCase(this._repository);

  Future<AppResult<List<ReviewItem>>> execute() {
    return _repository.getTodayReviews();
  }
}
