import 'package:equatable/equatable.dart';

class CalendarEventDraft extends Equatable {
  final String id;
  final String? taskId;
  final String title;
  final String? description;
  final DateTime startAt;
  final DateTime endAt;
  final String timezone;
  final int reminderMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CalendarEventDraft({
    required this.id,
    this.taskId,
    required this.title,
    this.description,
    required this.startAt,
    required this.endAt,
    this.timezone = 'UTC',
    this.reminderMinutes = 10,
    required this.createdAt,
    required this.updatedAt,
  });

  CalendarEventDraft copyWith({
    String? id,
    String? taskId,
    String? title,
    String? description,
    DateTime? startAt,
    DateTime? endAt,
    String? timezone,
    int? reminderMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CalendarEventDraft(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      description: description ?? this.description,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      timezone: timezone ?? this.timezone,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, taskId, title, description, startAt, endAt,
        timezone, reminderMinutes, createdAt, updatedAt,
      ];
}
