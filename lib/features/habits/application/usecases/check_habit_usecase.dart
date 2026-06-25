import 'package:uuid/uuid.dart';
import '../../domain/entities/habit_log.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../../../core/result/app_result.dart';

class CheckHabitUseCase {
  final HabitRepository _repository;
  static const _uuid = Uuid();

  CheckHabitUseCase(this._repository);

  Future<AppResult<HabitLog>> execute(String habitId) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final log = HabitLog(
      id: _uuid.v4(),
      habitId: habitId,
      date: today,
      count: 1,
      completed: true,
      createdAt: now,
      updatedAt: now,
    );
    return _repository.saveLog(log);
  }
}
