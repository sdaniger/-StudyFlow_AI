import '../../../../core/result/app_result.dart';
import '../entities/review_item.dart';

abstract class ReviewRepository {
  Future<AppResult<List<ReviewItem>>> getAll();
  Future<AppResult<List<ReviewItem>>> getTodayReviews();
  Future<AppResult<List<ReviewItem>>> getByTaskId(String taskId);
  Future<AppResult<ReviewItem>> save(ReviewItem item);
  Future<AppResult<ReviewItem>> update(ReviewItem item);
  Future<AppResult<void>> delete(String id);
  Future<AppResult<void>> saveAll(List<ReviewItem> items);
}
