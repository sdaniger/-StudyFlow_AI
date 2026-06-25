import 'package:equatable/equatable.dart';

class AppBackupData extends Equatable {
  final String version;
  final DateTime exportedAt;
  final List<Map<String, dynamic>> tasks;
  final List<Map<String, dynamic>> habits;
  final List<Map<String, dynamic>> habitLogs;
  final List<Map<String, dynamic>> reviewItems;
  final List<Map<String, dynamic>> pomodoroSessions;
  final Map<String, dynamic>? settings;

  const AppBackupData({
    required this.version,
    required this.exportedAt,
    required this.tasks,
    required this.habits,
    required this.habitLogs,
    required this.reviewItems,
    required this.pomodoroSessions,
    this.settings,
  });

  @override
  List<Object?> get props => [
        version, exportedAt, tasks, habits, habitLogs,
        reviewItems, pomodoroSessions, settings,
      ];
}
