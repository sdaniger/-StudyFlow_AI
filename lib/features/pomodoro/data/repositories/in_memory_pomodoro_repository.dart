import '../../domain/entities/pomodoro_session.dart';
import '../../domain/repositories/pomodoro_repository.dart';
import '../../../../core/result/app_result.dart';
import '../../../../core/errors/app_error.dart';

class InMemoryPomodoroRepository implements PomodoroRepository {
  final _sessions = <String, PomodoroSession>{};

  @override
  Future<AppResult<PomodoroSession>> save(PomodoroSession session) async {
    _sessions[session.id] = session;
    return AppSuccess(session);
  }

  @override
  Future<AppResult<PomodoroSession>> update(PomodoroSession session) async {
    if (!_sessions.containsKey(session.id)) {
      return AppFailure(DatabaseError('PomodoroSession not found: ${session.id}'));
    }
    _sessions[session.id] = session;
    return AppSuccess(session);
  }

  @override
  Future<AppResult<List<PomodoroSession>>> getAll() async {
    final list = _sessions.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return AppSuccess(list);
  }

  @override
  Future<AppResult<List<PomodoroSession>>> getTodaySessions() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final todaySessions = _sessions.values.where((s) {
      if (s.startedAt == null) return false;
      final start = DateTime(
        s.startedAt!.year,
        s.startedAt!.month,
        s.startedAt!.day,
      );
      return start.compareTo(today) >= 0 && start.compareTo(tomorrow) < 0;
    }).toList();

    return AppSuccess(todaySessions);
  }
}
