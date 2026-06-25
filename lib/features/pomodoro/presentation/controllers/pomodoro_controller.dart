import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/pomodoro_mode.dart';
import '../../../../core/constants/app_constants.dart';

class PomodoroController extends StateNotifier<PomodoroState> {
  Timer? _timer;

  PomodoroController()
      : super(PomodoroState(
          mode: PomodoroMode.focus,
          secondsRemaining: AppConstants.defaultPomodoroFocusMinutes * 60,
          totalSeconds: AppConstants.defaultPomodoroFocusMinutes * 60,
          isRunning: false,
          sessionCount: 0,
        ));

  void start() {
    if (state.isRunning) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.secondsRemaining > 0) {
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
        _completeSession();
      }
    });
    state = state.copyWith(isRunning: true);
  }

  void pause() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  void reset() {
    _timer?.cancel();
    state = state.copyWith(
      secondsRemaining: state.totalSeconds,
      isRunning: false,
    );
  }

  void setMode(PomodoroMode mode) {
    _timer?.cancel();
    final totalSeconds = mode.defaultMinutes * 60;
    state = state.copyWith(
      mode: mode,
      secondsRemaining: totalSeconds,
      totalSeconds: totalSeconds,
      isRunning: false,
    );
  }

  void _completeSession() {
    _timer?.cancel();
    final newSessionCount =
        state.mode == PomodoroMode.focus ? state.sessionCount + 1 : state.sessionCount;
    state = state.copyWith(isRunning: false, sessionCount: newSessionCount);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class PomodoroState {
  final PomodoroMode mode;
  final int secondsRemaining;
  final int totalSeconds;
  final bool isRunning;
  final int sessionCount;

  const PomodoroState({
    required this.mode,
    required this.secondsRemaining,
    required this.totalSeconds,
    required this.isRunning,
    required this.sessionCount,
  });

  PomodoroState copyWith({
    PomodoroMode? mode,
    int? secondsRemaining,
    int? totalSeconds,
    bool? isRunning,
    int? sessionCount,
  }) {
    return PomodoroState(
      mode: mode ?? this.mode,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      isRunning: isRunning ?? this.isRunning,
      sessionCount: sessionCount ?? this.sessionCount,
    );
  }
}

final pomodoroControllerProvider =
    StateNotifierProvider<PomodoroController, PomodoroState>((ref) {
  return PomodoroController();
});
