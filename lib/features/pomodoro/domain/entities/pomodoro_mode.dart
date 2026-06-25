enum PomodoroMode {
  focus,
  shortBreak,
  longBreak;

  String get label {
    switch (this) {
      case PomodoroMode.focus:
        return 'Focus';
      case PomodoroMode.shortBreak:
        return 'Short Break';
      case PomodoroMode.longBreak:
        return 'Long Break';
    }
  }

  int get defaultMinutes {
    switch (this) {
      case PomodoroMode.focus:
        return 25;
      case PomodoroMode.shortBreak:
        return 5;
      case PomodoroMode.longBreak:
        return 15;
    }
  }
}
