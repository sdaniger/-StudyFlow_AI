import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:studyflow_ai/features/tasks/domain/entities/task.dart';
import 'package:studyflow_ai/features/tasks/domain/entities/task_status.dart';
import 'package:studyflow_ai/features/tasks/domain/entities/task_priority.dart';
import 'package:studyflow_ai/features/tasks/data/repositories/in_memory_task_repository.dart';
import 'package:studyflow_ai/core/result/app_result.dart';

void main() {
  late InMemoryTaskRepository repository;
  late Task sampleTask;

  setUp(() {
    repository = InMemoryTaskRepository();
    final now = DateTime.now();
    sampleTask = Task(
      id: const Uuid().v4(),
      title: 'Test Task',
      subject: 'Test',
      status: TaskStatus.todo,
      priority: TaskPriority.medium,
      createdAt: now,
      updatedAt: now,
    );
  });

  group('TaskRepository', () {
    test('save and retrieve task', () async {
      final saveResult = await repository.save(sampleTask);
      expect(saveResult, isA<AppSuccess<Task>>());

      final getResult = await repository.getById(sampleTask.id);
      expect(getResult, isA<AppSuccess<Task>>());
      final task = (getResult as AppSuccess<Task>).data;
      expect(task.title, 'Test Task');
    });

    test('delete task marks as deleted', () async {
      await repository.save(sampleTask);
      final deleteResult = await repository.delete(sampleTask.id);
      expect(deleteResult, isA<AppSuccess<void>>());

      final getResult = await repository.getById(sampleTask.id);
      expect(getResult, isA<AppFailure<Task>>());
    });

    test('getAll returns only active tasks', () async {
      await repository.save(sampleTask);
      final task2 = sampleTask.copyWith(id: const Uuid().v4(), title: 'Task 2');
      await repository.save(task2);
      await repository.delete(task2.id);

      final result = await repository.getAll();
      expect(result, isA<AppSuccess<List<Task>>>());
      final tasks = (result as AppSuccess<List<Task>>).data;
      expect(tasks.length, 1);
      expect(tasks.first.title, 'Test Task');
    });

    test('update task changes fields', () async {
      await repository.save(sampleTask);
      final updated = sampleTask.copyWith(title: 'Updated Task');
      final updateResult = await repository.update(updated);
      expect(updateResult, isA<AppSuccess<Task>>());

      final getResult = await repository.getById(sampleTask.id);
      final task = (getResult as AppSuccess<Task>).data;
      expect(task.title, 'Updated Task');
    });
  });
}
