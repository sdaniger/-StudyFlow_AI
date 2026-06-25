import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/in_memory_pomodoro_repository.dart';
import '../../domain/repositories/pomodoro_repository.dart';

final pomodoroRepositoryProvider = Provider<PomodoroRepository>((ref) {
  return InMemoryPomodoroRepository();
});
