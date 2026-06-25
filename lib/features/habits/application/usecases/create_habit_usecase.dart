import 'package:uuid/uuid.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_frequency.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../../../core/result/app_result.dart';

class CreateHabitUseCase {
  final HabitRepository _repository;
  static const _uuid = Uuid();

  CreateHabitUseCase(this._repository);

  Future<AppResult<Habit>> execute({
    required String title,
    String? subject,
    HabitFrequency frequency = HabitFrequency.daily,
    int targetCount = 1,
  }) {
    final now = DateTime.now();
    final habit = Habit(
      id: _uuid.v4(),
      title: title,
      subject: subject,
      frequency: frequency,
      targetCount: targetCount,
      createdAt: now,
      updatedAt: now,
    );
    return _repository.save(habit);
  }
}
