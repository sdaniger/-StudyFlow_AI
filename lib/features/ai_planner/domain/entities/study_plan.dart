import 'package:equatable/equatable.dart';

class StudyPlan extends Equatable {
  final String id;
  final String goal;
  final List<String> todayTasks;
  final List<String> weeklyTasks;
  final List<String> reviewSuggestions;
  final List<String> calendarSuggestions;
  final String advice;
  final DateTime createdAt;

  const StudyPlan({
    required this.id,
    required this.goal,
    required this.todayTasks,
    required this.weeklyTasks,
    required this.reviewSuggestions,
    required this.calendarSuggestions,
    required this.advice,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id, goal, todayTasks, weeklyTasks,
        reviewSuggestions, calendarSuggestions, advice, createdAt,
      ];
}
