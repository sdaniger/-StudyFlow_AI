import 'package:equatable/equatable.dart';

class StudyPlanRequest extends Equatable {
  final String goal;
  final DateTime? deadline;
  final int dailyStudyMinutes;
  final String? subject;
  final String? difficulty;
  final String? concerns;

  const StudyPlanRequest({
    required this.goal,
    this.deadline,
    this.dailyStudyMinutes = 120,
    this.subject,
    this.difficulty,
    this.concerns,
  });

  @override
  List<Object?> get props => [
        goal, deadline, dailyStudyMinutes, subject, difficulty, concerns,
      ];
}
