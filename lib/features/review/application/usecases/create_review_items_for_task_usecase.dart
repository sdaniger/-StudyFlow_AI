import 'package:uuid/uuid.dart';
import '../../domain/services/review_schedule_policy.dart';
import '../../domain/repositories/review_repository.dart';
import '../../../../core/result/app_result.dart';

class CreateReviewItemsForTaskUseCase {
  final ReviewRepository _repository;
  final ReviewSchedulePolicy _policy;
  static const _uuid = Uuid();

  CreateReviewItemsForTaskUseCase(this._repository, this._policy);

  Future<AppResult<void>> execute({
    required String sourceTaskId,
    required String title,
    String? subject,
    required DateTime learnedAt,
  }) {
    final items = _policy.generateSchedule(
      sourceTaskId: sourceTaskId,
      title: title,
      subject: subject,
      learnedAt: learnedAt,
      generateId: () => _uuid.v4(),
    );
    return _repository.saveAll(items);
  }
}
