import 'package:equatable/equatable.dart';

class HabitLog extends Equatable {
  final String id;
  final String habitId;
  final DateTime date;
  final int count;
  final bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;

  const HabitLog({
    required this.id,
    required this.habitId,
    required this.date,
    this.count = 1,
    this.completed = true,
    required this.createdAt,
    required this.updatedAt,
  });

  HabitLog copyWith({
    String? id,
    String? habitId,
    DateTime? date,
    int? count,
    bool? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HabitLog(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      count: count ?? this.count,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        habitId,
        date,
        count,
        completed,
        createdAt,
        updatedAt,
      ];
}
