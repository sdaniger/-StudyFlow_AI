import 'package:equatable/equatable.dart';
import 'habit_frequency.dart';

class Habit extends Equatable {
  final String id;
  final String title;
  final String? subject;
  final HabitFrequency frequency;
  final int targetCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Habit({
    required this.id,
    required this.title,
    this.subject,
    this.frequency = HabitFrequency.daily,
    this.targetCount = 1,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? subject,
    HabitFrequency? frequency,
    int? targetCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      frequency: frequency ?? this.frequency,
      targetCount: targetCount ?? this.targetCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: clearDeletedAt ? null : (deletedAt ?? this.deletedAt),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        subject,
        frequency,
        targetCount,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
