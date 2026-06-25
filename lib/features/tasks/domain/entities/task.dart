import 'package:equatable/equatable.dart';
import 'task_status.dart';
import 'task_priority.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? subject;
  final TaskStatus status;
  final TaskPriority priority;
  final DateTime? dueDate;
  final int? estimatedMinutes;
  final int? actualMinutes;
  final bool createdByAi;
  final String? parentTaskId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.subject,
    this.status = TaskStatus.todo,
    this.priority = TaskPriority.medium,
    this.dueDate,
    this.estimatedMinutes,
    this.actualMinutes,
    this.createdByAi = false,
    this.parentTaskId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? subject,
    TaskStatus? status,
    TaskPriority? priority,
    DateTime? dueDate,
    int? estimatedMinutes,
    int? actualMinutes,
    bool? createdByAi,
    String? parentTaskId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subject: subject ?? this.subject,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      actualMinutes: actualMinutes ?? this.actualMinutes,
      createdByAi: createdByAi ?? this.createdByAi,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: clearDeletedAt ? null : (deletedAt ?? this.deletedAt),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        subject,
        status,
        priority,
        dueDate,
        estimatedMinutes,
        actualMinutes,
        createdByAi,
        parentTaskId,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
