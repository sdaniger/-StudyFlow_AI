import 'package:equatable/equatable.dart';

class GoalDecompositionRequest extends Equatable {
  final String goal;
  final String? subject;
  final String? difficulty;

  const GoalDecompositionRequest({
    required this.goal,
    this.subject,
    this.difficulty,
  });

  @override
  List<Object?> get props => [goal, subject, difficulty];
}
