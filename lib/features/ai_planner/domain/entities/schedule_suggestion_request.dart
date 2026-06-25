import 'package:equatable/equatable.dart';

class ScheduleSuggestionRequest extends Equatable {
  final List<String> taskIds;
  final DateTime? date;

  const ScheduleSuggestionRequest({
    required this.taskIds,
    this.date,
  });

  @override
  List<Object?> get props => [taskIds, date];
}
