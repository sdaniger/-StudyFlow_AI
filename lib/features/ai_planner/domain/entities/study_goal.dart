import 'package:equatable/equatable.dart';

class StudyGoal extends Equatable {
  final String id;
  final String title;
  final String? subject;
  final DateTime? deadline;
  final int? dailyStudyMinutes;
  final String? difficulty;
  final String? concerns;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StudyGoal({
    required this.id,
    required this.title,
    this.subject,
    this.deadline,
    this.dailyStudyMinutes,
    this.difficulty,
    this.concerns,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id, title, subject, deadline, dailyStudyMinutes,
        difficulty, concerns, createdAt, updatedAt,
      ];
}
