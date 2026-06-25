enum HabitFrequency {
  daily,
  weekly,
  weekday,
  weekend;

  String get label {
    switch (this) {
      case HabitFrequency.daily:
        return 'Every Day';
      case HabitFrequency.weekly:
        return 'Weekly';
      case HabitFrequency.weekday:
        return 'Weekdays';
      case HabitFrequency.weekend:
        return 'Weekends';
    }
  }
}
