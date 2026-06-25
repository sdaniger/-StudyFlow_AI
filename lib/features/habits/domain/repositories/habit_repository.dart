import '../../../../core/result/app_result.dart';
import '../entities/habit.dart';
import '../entities/habit_log.dart';

abstract class HabitRepository {
  Future<AppResult<List<Habit>>> getAll();
  Future<AppResult<Habit>> save(Habit habit);
  Future<AppResult<Habit>> update(Habit habit);
  Future<AppResult<void>> delete(String id);

  Future<AppResult<List<HabitLog>>> getLogsForHabit(String habitId);
  Future<AppResult<HabitLog>> saveLog(HabitLog log);
  Future<AppResult<List<HabitLog>>> getTodayLogs();
}
