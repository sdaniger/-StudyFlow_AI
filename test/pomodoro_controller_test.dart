import 'package:flutter_test/flutter_test.dart';
import 'package:studyflow_ai/features/pomodoro/presentation/controllers/pomodoro_controller.dart';
import 'package:studyflow_ai/features/pomodoro/domain/entities/pomodoro_mode.dart';
import 'package:studyflow_ai/core/constants/app_constants.dart';

void main() {
  group('PomodoroController', () {
    test('initial state is focus mode with 25 minutes', () {
      final state = PomodoroState(
        mode: PomodoroMode.focus,
        secondsRemaining: AppConstants.defaultPomodoroFocusMinutes * 60,
        totalSeconds: AppConstants.defaultPomodoroFocusMinutes * 60,
        isRunning: false,
        sessionCount: 0,
      );

      expect(state.mode, PomodoroMode.focus);
      expect(state.secondsRemaining, 1500);
      expect(state.isRunning, false);
      expect(state.sessionCount, 0);
    });

    test('setMode changes mode and resets timer', () {
      final state1 = PomodoroState(
        mode: PomodoroMode.focus,
        secondsRemaining: 1500,
        totalSeconds: 1500,
        isRunning: true,
        sessionCount: 1,
      );

      final state2 = state1.copyWith(
        mode: PomodoroMode.shortBreak,
        secondsRemaining: PomodoroMode.shortBreak.defaultMinutes * 60,
        totalSeconds: PomodoroMode.shortBreak.defaultMinutes * 60,
        isRunning: false,
      );

      expect(state2.mode, PomodoroMode.shortBreak);
      expect(state2.secondsRemaining, 300);
      expect(state2.isRunning, false);
    });

    test('copyWith preserves unchanged fields', () {
      final state = PomodoroState(
        mode: PomodoroMode.focus,
        secondsRemaining: 1500,
        totalSeconds: 1500,
        isRunning: true,
        sessionCount: 2,
      );

      final updated = state.copyWith(isRunning: false);
      expect(updated.mode, PomodoroMode.focus);
      expect(updated.secondsRemaining, 1500);
      expect(updated.isRunning, false);
      expect(updated.sessionCount, 2);
    });
  });
}
