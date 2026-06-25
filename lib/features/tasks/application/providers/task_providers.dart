import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/in_memory_task_repository.dart';
import '../../domain/repositories/task_repository.dart';
import '../usecases/create_task_usecase.dart';
import '../usecases/update_task_usecase.dart';
import '../usecases/delete_task_usecase.dart';
import '../usecases/complete_task_usecase.dart';
import '../usecases/get_today_tasks_usecase.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return InMemoryTaskRepository();
});

final createTaskUseCaseProvider = Provider<CreateTaskUseCase>((ref) {
  return CreateTaskUseCase(ref.watch(taskRepositoryProvider));
});

final updateTaskUseCaseProvider = Provider<UpdateTaskUseCase>((ref) {
  return UpdateTaskUseCase(ref.watch(taskRepositoryProvider));
});

final deleteTaskUseCaseProvider = Provider<DeleteTaskUseCase>((ref) {
  return DeleteTaskUseCase(ref.watch(taskRepositoryProvider));
});

final completeTaskUseCaseProvider = Provider<CompleteTaskUseCase>((ref) {
  return CompleteTaskUseCase(ref.watch(taskRepositoryProvider));
});

final getTodayTasksUseCaseProvider = Provider<GetTodayTasksUseCase>((ref) {
  return GetTodayTasksUseCase(ref.watch(taskRepositoryProvider));
});

final taskListProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final result = await repo.getAll();
  return result;
});

final todayTasksProvider = FutureProvider.autoDispose((ref) async {
  final useCase = ref.watch(getTodayTasksUseCaseProvider);
  return useCase.execute();
});
