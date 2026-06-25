import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/habit_providers.dart';

class HabitController {
  final Ref _ref;

  HabitController(this._ref);

  Future<void> createHabit({
    required String title,
    String? subject,
  }) async {
    final useCase = _ref.read(createHabitUseCaseProvider);
    await useCase.execute(title: title, subject: subject);
    _ref.invalidate(habitListProvider);
    _ref.invalidate(todayHabitLogsProvider);
  }

  Future<void> checkHabit(String habitId) async {
    final useCase = _ref.read(checkHabitUseCaseProvider);
    await useCase.execute(habitId);
    _ref.invalidate(todayHabitLogsProvider);
  }
}

final habitControllerProvider = Provider<HabitController>((ref) {
  return HabitController(ref);
});
