import 'package:equatable/equatable.dart';

class ScheduleSuggestion extends Equatable {
  final String taskTitle;
  final String? subject;
  final int estimatedMinutes;
  final String? timeSlot;
  final String reason;

  const ScheduleSuggestion({
    required this.taskTitle,
    this.subject,
    required this.estimatedMinutes,
    this.timeSlot,
    required this.reason,
  });

  @override
  List<Object?> get props => [
        taskTitle, subject, estimatedMinutes, timeSlot, reason,
      ];
}
