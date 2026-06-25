import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:studyflow_ai/features/tasks/domain/entities/task.dart';
import 'package:studyflow_ai/features/tasks/domain/entities/task_status.dart';
import 'package:studyflow_ai/features/tasks/domain/entities/task_priority.dart';
import 'package:studyflow_ai/features/tasks/data/repositories/in_memory_task_repository.dart';
import 'package:studyflow_ai/features/tasks/application/usecases/complete_task_usecase.dart';
import 'package:studyflow_ai/core/result/app_result.dart';

void main() {
  late InMemoryTaskRepository repository;
  late CompleteTaskUseCase useCase;
  late Task task;

  setUp(() {
    repository = InMemoryTaskRepository();
    useCase = CompleteTaskUseCase(repository);
    final now = DateTime.now();
    task = Task(
      id: const Uuid().v4(),
      title: 'Test Task',
      subject: 'Test',
      status: TaskStatus.todo,
      priority: TaskPriority.medium,
      estimatedMinutes: 30,
      createdAt: now,
      updatedAt: now,
    );
  });

  group('CompleteTaskUseCase', () {
    test('completes task and updates status', () async {
      await repository.save(task);

      final result = await useCase.execute(task, actualMinutes: 25);
      expect(result, isA<AppSuccess<Task>>());

      final completed = (result as AppSuccess<Task>).data;
      expect(completed.status, TaskStatus.done);
      expect(completed.actualMinutes, 25);
    });

    test('completes task without actual minutes', () async {
      await repository.save(task);

      final result = await useCase.execute(task);
      expect(result, isA<AppSuccess<Task>>());

      final completed = (result as AppSuccess<Task>).data;
      expect(completed.status, TaskStatus.done);
      expect(completed.actualMinutes, isNull);
    });
  });
}
