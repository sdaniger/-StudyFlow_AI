import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../../../../core/result/app_result.dart';

class GetTodayTasksUseCase {
  final TaskRepository _repository;

  GetTodayTasksUseCase(this._repository);

  Future<AppResult<List<Task>>> execute() {
    return _repository.getTodayTasks();
  }
}
