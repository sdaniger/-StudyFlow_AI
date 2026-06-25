import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_priority.dart';
import '../../application/providers/task_providers.dart';

class TaskController {
  final Ref _ref;

  TaskController(this._ref);

  Future<void> createTask({
    required String title,
    String? description,
    String? subject,
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
    int? estimatedMinutes,
    bool createdByAi = false,
    String? parentTaskId,
  }) async {
    final useCase = _ref.read(createTaskUseCaseProvider);
    await useCase.execute(
      title: title,
      description: description,
      subject: subject,
      priority: priority,
      dueDate: dueDate,
      estimatedMinutes: estimatedMinutes,
      createdByAi: createdByAi,
      parentTaskId: parentTaskId,
    );
    _ref.invalidate(taskListProvider);
    _ref.invalidate(todayTasksProvider);
  }

  Future<void> updateTask(Task task) async {
    final useCase = _ref.read(updateTaskUseCaseProvider);
    await useCase.execute(task);
    _ref.invalidate(taskListProvider);
    _ref.invalidate(todayTasksProvider);
  }

  Future<void> deleteTask(String id) async {
    final useCase = _ref.read(deleteTaskUseCaseProvider);
    await useCase.execute(id);
    _ref.invalidate(taskListProvider);
    _ref.invalidate(todayTasksProvider);
  }

  Future<void> completeTask(Task task, {int? actualMinutes}) async {
    final useCase = _ref.read(completeTaskUseCaseProvider);
    await useCase.execute(task, actualMinutes: actualMinutes);
    _ref.invalidate(taskListProvider);
    _ref.invalidate(todayTasksProvider);
  }
}

final taskControllerProvider = Provider<TaskController>((ref) {
  return TaskController(ref);
});
