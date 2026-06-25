import 'package:equatable/equatable.dart';
import 'pomodoro_mode.dart';

class PomodoroSession extends Equatable {
  final String id;
  final String? taskId;
  final PomodoroMode mode;
  final int plannedMinutes;
  final int? actualMinutes;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PomodoroSession({
    required this.id,
    this.taskId,
    required this.mode,
    required this.plannedMinutes,
    this.actualMinutes,
    this.startedAt,
    this.endedAt,
    this.completed = false,
    required this.createdAt,
    required this.updatedAt,
  });

  PomodoroSession copyWith({
    String? id,
    String? taskId,
    PomodoroMode? mode,
    int? plannedMinutes,
    int? actualMinutes,
    DateTime? startedAt,
    DateTime? endedAt,
    bool? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearTaskId = false,
  }) {
    return PomodoroSession(
      id: id ?? this.id,
      taskId: clearTaskId ? null : (taskId ?? this.taskId),
      mode: mode ?? this.mode,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      actualMinutes: actualMinutes ?? this.actualMinutes,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        taskId,
        mode,
        plannedMinutes,
        actualMinutes,
        startedAt,
        endedAt,
        completed,
        createdAt,
        updatedAt,
      ];
}
