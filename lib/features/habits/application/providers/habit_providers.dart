import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/in_memory_habit_repository.dart';
import '../../domain/repositories/habit_repository.dart';
import '../usecases/create_habit_usecase.dart';
import '../usecases/check_habit_usecase.dart';
import '../usecases/calculate_habit_streak_usecase.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return InMemoryHabitRepository();
});

final createHabitUseCaseProvider = Provider<CreateHabitUseCase>((ref) {
  return CreateHabitUseCase(ref.watch(habitRepositoryProvider));
});

final checkHabitUseCaseProvider = Provider<CheckHabitUseCase>((ref) {
  return CheckHabitUseCase(ref.watch(habitRepositoryProvider));
});

final calculateHabitStreakUseCaseProvider =
    Provider<CalculateHabitStreakUseCase>((ref) {
  return CalculateHabitStreakUseCase(ref.watch(habitRepositoryProvider));
});

final habitListProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(habitRepositoryProvider);
  return repo.getAll();
});

final todayHabitLogsProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(habitRepositoryProvider);
  return repo.getTodayLogs();
});
