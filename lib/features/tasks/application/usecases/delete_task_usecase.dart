import '../../domain/repositories/task_repository.dart';
import '../../../../core/result/app_result.dart';

class DeleteTaskUseCase {
  final TaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  Future<AppResult<void>> execute(String id) {
    return _repository.delete(id);
  }
}
