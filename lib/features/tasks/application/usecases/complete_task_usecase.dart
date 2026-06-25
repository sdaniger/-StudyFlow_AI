import '../../domain/entities/task.dart';
import '../../domain/entities/task_status.dart';
import '../../domain/repositories/task_repository.dart';
import '../../../../core/result/app_result.dart';

class CompleteTaskUseCase {
  final TaskRepository _repository;

  CompleteTaskUseCase(this._repository);

  Future<AppResult<Task>> execute(Task task, {int? actualMinutes}) {
    final updated = task.copyWith(
      status: TaskStatus.done,
      updatedAt: DateTime.now(),
      actualMinutes: actualMinutes ?? task.actualMinutes,
    );
    return _repository.update(updated);
  }
}
