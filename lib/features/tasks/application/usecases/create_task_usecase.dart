import 'package:uuid/uuid.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_status.dart';
import '../../domain/entities/task_priority.dart';
import '../../domain/repositories/task_repository.dart';
import '../../../../core/result/app_result.dart';

class CreateTaskUseCase {
  final TaskRepository _repository;
  static const _uuid = Uuid();

  CreateTaskUseCase(this._repository);

  Future<AppResult<Task>> execute({
    required String title,
    String? description,
    String? subject,
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
    int? estimatedMinutes,
    bool createdByAi = false,
    String? parentTaskId,
  }) {
    final now = DateTime.now();
    final task = Task(
      id: _uuid.v4(),
      title: title,
      description: description,
      subject: subject,
      status: TaskStatus.todo,
      priority: priority,
      dueDate: dueDate,
      estimatedMinutes: estimatedMinutes,
      createdByAi: createdByAi,
      parentTaskId: parentTaskId,
      createdAt: now,
      updatedAt: now,
    );
    return _repository.save(task);
  }
}
