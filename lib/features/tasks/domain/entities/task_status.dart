enum TaskStatus {
  todo,
  inProgress,
  done,
  archived;

  String get label {
    switch (this) {
      case TaskStatus.todo:
        return 'To Do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
      case TaskStatus.archived:
        return 'Archived';
    }
  }

  bool get isActive => this == TaskStatus.todo || this == TaskStatus.inProgress;
}
