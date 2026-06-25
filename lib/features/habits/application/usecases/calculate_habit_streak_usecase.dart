import '../../domain/entities/habit_log.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../../../core/result/app_result.dart';
import '../../../../core/errors/app_error.dart';

class CalculateHabitStreakUseCase {
  final HabitRepository _repository;

  CalculateHabitStreakUseCase(this._repository);

  Future<AppResult<int>> execute(String habitId) async {
    final result = await _repository.getLogsForHabit(habitId);
    if (result is AppSuccess<List<HabitLog>>) {
      final logs = result.data;
      if (logs.isEmpty) return const AppSuccess(0);

      int streak = 0;
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);

      for (final log in logs) {
        final expected = todayDate.subtract(Duration(days: streak));
        if (log.date.isAtSameMomentAs(expected)) {
          streak++;
        } else {
          break;
        }
      }

      return AppSuccess(streak);
    }
    if (result is AppFailure<List<HabitLog>>) {
      return AppFailure(result.error);
    }
    return const AppFailure(UnknownError());
  }
}
