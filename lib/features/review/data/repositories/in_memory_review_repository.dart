import '../../domain/entities/review_item.dart';
import '../../domain/entities/review_status.dart';
import '../../domain/repositories/review_repository.dart';
import '../../../../core/result/app_result.dart';
import '../../../../core/errors/app_error.dart';

class InMemoryReviewRepository implements ReviewRepository {
  final _items = <String, ReviewItem>{};

  InMemoryReviewRepository({List<ReviewItem>? initialData}) {
    if (initialData != null) {
      for (final item in initialData) {
        _items[item.id] = item;
      }
    }
  }

  @override
  Future<AppResult<List<ReviewItem>>> getAll() async {
    final active = _items.values
        .where((i) => i.deletedAt == null)
        .toList()
      ..sort((a, b) => a.nextReviewAt.compareTo(b.nextReviewAt));
    return AppSuccess(active);
  }

  @override
  Future<AppResult<List<ReviewItem>>> getTodayReviews() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final todayItems = _items.values.where((i) {
      if (i.deletedAt != null) return false;
      if (i.status == ReviewStatus.archived) return false;
      final reviewDate = DateTime(
        i.nextReviewAt.year,
        i.nextReviewAt.month,
        i.nextReviewAt.day,
      );
      return !reviewDate.isAfter(today) && !reviewDate.isBefore(today);
    }).toList()
      ..sort((a, b) => a.nextReviewAt.compareTo(b.nextReviewAt));

    return AppSuccess(todayItems);
  }

  @override
  Future<AppResult<List<ReviewItem>>> getByTaskId(String taskId) async {
    final filtered = _items.values
        .where((i) => i.deletedAt == null && i.sourceTaskId == taskId)
        .toList();
    return AppSuccess(filtered);
  }

  @override
  Future<AppResult<ReviewItem>> save(ReviewItem item) async {
    _items[item.id] = item;
    return AppSuccess(item);
  }

  @override
  Future<AppResult<ReviewItem>> update(ReviewItem item) async {
    if (!_items.containsKey(item.id)) {
      return AppFailure(DatabaseError('ReviewItem not found: ${item.id}'));
    }
    _items[item.id] = item;
    return AppSuccess(item);
  }

  @override
  Future<AppResult<void>> delete(String id) async {
    final item = _items[id];
    if (item == null) {
      return AppFailure(DatabaseError('ReviewItem not found: $id'));
    }
    _items[id] = item.copyWith(deletedAt: DateTime.now());
    return const AppSuccess(null);
  }

  @override
  Future<AppResult<void>> saveAll(List<ReviewItem> items) async {
    for (final item in items) {
      _items[item.id] = item;
    }
    return const AppSuccess(null);
  }
}
