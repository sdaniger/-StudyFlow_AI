import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:studyflow_ai/features/habits/domain/entities/habit_log.dart';
import 'package:studyflow_ai/features/habits/data/repositories/in_memory_habit_repository.dart';
import 'package:studyflow_ai/features/habits/application/usecases/calculate_habit_streak_usecase.dart';
import 'package:studyflow_ai/core/result/app_result.dart';

void main() {
  group('Habit Streak Calculation', () {
    test('returns 0 for new habit with no logs', () async {
      final repository = InMemoryHabitRepository();
      final useCase = CalculateHabitStreakUseCase(repository);
      final habitId = const Uuid().v4();

      final result = await useCase.execute(habitId);
      expect(result, isA<AppSuccess<int>>());
      expect((result as AppSuccess<int>).data, 0);
    });

    test('calculates consecutive daily streak', () async {
      final repository = InMemoryHabitRepository();
      final useCase = CalculateHabitStreakUseCase(repository);
      final habitId = const Uuid().v4();

      final now = DateTime.now();
      for (int i = 0; i < 3; i++) {
        final date = DateTime(now.year, now.month, now.day - i);
        final log = HabitLog(
          id: const Uuid().v4(),
          habitId: habitId,
          date: date,
          count: 1,
          completed: true,
          createdAt: now,
          updatedAt: now,
        );
        await repository.saveLog(log);
      }

      final result = await useCase.execute(habitId);
      expect(result, isA<AppSuccess<int>>());
      expect((result as AppSuccess<int>).data, 3);
    });
  });
}
