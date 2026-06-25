import '../../../../core/result/app_result.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<AppResult<List<Task>>> getAll();
  Future<AppResult<List<Task>>> getTodayTasks();
  Future<AppResult<List<Task>>> getBySubject(String subject);
  Future<AppResult<Task>> getById(String id);
  Future<AppResult<Task>> save(Task task);
  Future<AppResult<Task>> update(Task task);
  Future<AppResult<void>> delete(String id);
  Future<AppResult<List<Task>>> getByParentId(String parentTaskId);
}
