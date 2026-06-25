import '../../domain/entities/task.dart';
import '../../domain/entities/task_status.dart';
import '../../domain/repositories/task_repository.dart';
import '../../../../core/result/app_result.dart';
import '../../../../core/errors/app_error.dart';

class InMemoryTaskRepository implements TaskRepository {
  final _tasks = <String, Task>{};

  @override
  Future<AppResult<List<Task>>> getAll() async {
    final active = _tasks.values
        .where((t) => t.deletedAt == null)
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return AppSuccess(active);
  }

  @override
  Future<AppResult<List<Task>>> getTodayTasks() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final todayTasks = _tasks.values.where((t) {
      if (t.deletedAt != null) return false;
      if (t.status == TaskStatus.archived) return false;
      if (t.dueDate == null) return true;
      final due = DateTime(
        t.dueDate!.year,
        t.dueDate!.month,
        t.dueDate!.day,
      );
      return due.isBefore(tomorrow) && due.isAfter(today.subtract(const Duration(days: 1)));
    }).toList()
      ..sort((a, b) => a.priority.value.compareTo(b.priority.value));

    return AppSuccess(todayTasks);
  }

  @override
  Future<AppResult<List<Task>>> getBySubject(String subject) async {
    final filtered = _tasks.values
        .where((t) => t.deletedAt == null && t.subject == subject)
        .toList();
    return AppSuccess(filtered);
  }

  @override
  Future<AppResult<Task>> getById(String id) async {
    final task = _tasks[id];
    if (task == null || task.deletedAt != null) {
      return AppFailure(DatabaseError('Task not found: $id'));
    }
    return AppSuccess(task);
  }

  @override
  Future<AppResult<Task>> save(Task task) async {
    _tasks[task.id] = task;
    return AppSuccess(task);
  }

  @override
  Future<AppResult<Task>> update(Task task) async {
    if (!_tasks.containsKey(task.id)) {
      return AppFailure(DatabaseError('Task not found: ${task.id}'));
    }
    _tasks[task.id] = task;
    return AppSuccess(task);
  }

  @override
  Future<AppResult<void>> delete(String id) async {
    final task = _tasks[id];
    if (task == null) {
      return AppFailure(DatabaseError('Task not found: $id'));
    }
    _tasks[id] = task.copyWith(deletedAt: DateTime.now());
    return const AppSuccess(null);
  }

  @override
  Future<AppResult<List<Task>>> getByParentId(String parentTaskId) async {
    final children = _tasks.values
        .where((t) => t.deletedAt == null && t.parentTaskId == parentTaskId)
        .toList();
    return AppSuccess(children);
  }
}
