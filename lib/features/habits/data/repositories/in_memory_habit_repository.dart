import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_log.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../../../core/result/app_result.dart';
import '../../../../core/errors/app_error.dart';

class InMemoryHabitRepository implements HabitRepository {
  final _habits = <String, Habit>{};
  final _logs = <String, HabitLog>{};

  InMemoryHabitRepository({List<Habit>? initialData}) {
    if (initialData != null) {
      for (final habit in initialData) {
        _habits[habit.id] = habit;
      }
    }
  }

  @override
  Future<AppResult<List<Habit>>> getAll() async {
    final active = _habits.values
        .where((h) => h.deletedAt == null)
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return AppSuccess(active);
  }

  @override
  Future<AppResult<Habit>> save(Habit habit) async {
    _habits[habit.id] = habit;
    return AppSuccess(habit);
  }

  @override
  Future<AppResult<Habit>> update(Habit habit) async {
    if (!_habits.containsKey(habit.id)) {
      return AppFailure(DatabaseError('Habit not found: ${habit.id}'));
    }
    _habits[habit.id] = habit;
    return AppSuccess(habit);
  }

  @override
  Future<AppResult<void>> delete(String id) async {
    final habit = _habits[id];
    if (habit == null) {
      return AppFailure(DatabaseError('Habit not found: $id'));
    }
    _habits[id] = habit.copyWith(deletedAt: DateTime.now());
    return const AppSuccess(null);
  }

  @override
  Future<AppResult<List<HabitLog>>> getLogsForHabit(String habitId) async {
    final logs = _logs.values
        .where((l) => l.habitId == habitId)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return AppSuccess(logs);
  }

  @override
  Future<AppResult<HabitLog>> saveLog(HabitLog log) async {
    _logs[log.id] = log;
    return AppSuccess(log);
  }

  @override
  Future<AppResult<List<HabitLog>>> getTodayLogs() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final todayLogs = _logs.values.where((l) {
      final logDate = DateTime(
        l.date.year,
        l.date.month,
        l.date.day,
      );
      return logDate.compareTo(today) >= 0 && logDate.compareTo(tomorrow) < 0;
    }).toList();

    return AppSuccess(todayLogs);
  }
}
