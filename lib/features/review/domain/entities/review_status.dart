enum ReviewStatus {
  scheduled,
  done,
  skipped,
  archived;

  String get label {
    switch (this) {
      case ReviewStatus.scheduled:
        return 'Scheduled';
      case ReviewStatus.done:
        return 'Done';
      case ReviewStatus.skipped:
        return 'Skipped';
      case ReviewStatus.archived:
        return 'Archived';
    }
  }
}
