import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../../../../core/result/app_result.dart';

class UpdateTaskUseCase {
  final TaskRepository _repository;

  UpdateTaskUseCase(this._repository);

  Future<AppResult<Task>> execute(Task task) {
    final updated = task.copyWith(updatedAt: DateTime.now());
    return _repository.update(updated);
  }
}
