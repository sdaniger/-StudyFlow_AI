import '../../../../core/result/app_result.dart';
import '../entities/pomodoro_session.dart';

abstract class PomodoroRepository {
  Future<AppResult<PomodoroSession>> save(PomodoroSession session);
  Future<AppResult<PomodoroSession>> update(PomodoroSession session);
  Future<AppResult<List<PomodoroSession>>> getAll();
  Future<AppResult<List<PomodoroSession>>> getTodaySessions();
}
