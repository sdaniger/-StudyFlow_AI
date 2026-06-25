import 'package:equatable/equatable.dart';

class SmallStep extends Equatable {
  final String id;
  final String taskId;
  final String title;
  final bool isCompleted;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SmallStep({
    required this.id,
    required this.taskId,
    required this.title,
    this.isCompleted = false,
    this.order = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  SmallStep copyWith({
    String? id,
    String? taskId,
    String? title,
    bool? isCompleted,
    int? order,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SmallStep(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      order: order ?? this.order,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, taskId, title, isCompleted, order, createdAt, updatedAt];
}
