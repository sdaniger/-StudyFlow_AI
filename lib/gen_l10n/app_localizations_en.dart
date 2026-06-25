import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'StudyFlow AI';

  @override
  String get appVersion => '1.0.0';

  @override
  String get navHome => 'Home';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navFocus => 'Focus';

  @override
  String get navHabits => 'Habits';

  @override
  String get navReview => 'Review';

  @override
  String get navAI => 'AI';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navDrive => 'Drive';

  @override
  String get navSettings => 'Settings';

  @override
  String get homeAppBarTitle => 'StudyFlow AI';

  @override
  String get homeAISuggestion => 'Finish reviewing English vocabulary first, then you can focus better on afternoon math.';

  @override
  String get homeTodayTasks => 'Today\'s Tasks';

  @override
  String get homeViewAll => 'View All';

  @override
  String get homeStatCompleted => 'Completed';

  @override
  String get homeStatFocusTime => 'Focus Time';

  @override
  String get homeStatFocusTimeDefault => '0m';

  @override
  String get homeNoTasks => 'No tasks for today. Add one!';

  @override
  String get tasksAppBarTitle => 'Tasks';

  @override
  String get tasksEmptyTitle => 'No tasks yet';

  @override
  String get tasksEmptySubtitle => 'Add a task to get started';

  @override
  String get tasksError => 'Error: ';

  @override
  String get tasksUnexpectedState => 'Unexpected state';

  @override
  String get taskEditAppBarNew => 'New Task';

  @override
  String get taskEditFieldTitle => 'Title';

  @override
  String get taskEditHintTitle => 'What do you want to study?';

  @override
  String get taskEditFieldDescription => 'Description';

  @override
  String get taskEditHintDescription => 'Add details...';

  @override
  String get taskEditFieldSubject => 'Subject';

  @override
  String get taskEditHintSubject => 'Select subject';

  @override
  String get taskEditFieldPriority => 'Priority';

  @override
  String get taskEditFieldDueDate => 'Due Date';

  @override
  String get taskEditPlaceholderDueDate => 'Set due date';

  @override
  String get taskEditButtonCreate => 'Create Task';

  @override
  String get subjectEnglish => 'English';

  @override
  String get subjectMathematics => 'Mathematics';

  @override
  String get subjectPhysics => 'Physics';

  @override
  String get subjectChemistry => 'Chemistry';

  @override
  String get subjectBiology => 'Biology';

  @override
  String get subjectHistory => 'History';

  @override
  String get subjectGeography => 'Geography';

  @override
  String get subjectLiterature => 'Literature';

  @override
  String get subjectProgramming => 'Programming';

  @override
  String get subjectOther => 'Other';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityUrgent => 'Urgent';

  @override
  String get statusTodo => 'To Do';

  @override
  String get statusInProgress => 'In Progress';

  @override
  String get statusDone => 'Done';

  @override
  String get statusArchived => 'Archived';

  @override
  String get habitFrequencyDaily => 'Every Day';

  @override
  String get habitFrequencyWeekly => 'Weekly';

  @override
  String get habitFrequencyWeekday => 'Weekdays';

  @override
  String get habitFrequencyWeekend => 'Weekends';

  @override
  String get pomodoroModeFocus => 'Focus';

  @override
  String get pomodoroModeShortBreak => 'Short Break';

  @override
  String get pomodoroModeLongBreak => 'Long Break';

  @override
  String get reviewStatusScheduled => 'Scheduled';

  @override
  String get reviewStatusDone => 'Done';

  @override
  String get reviewStatusSkipped => 'Skipped';

  @override
  String get reviewStatusArchived => 'Archived';

  @override
  String get reviewAppBarTitle => 'Review';

  @override
  String get reviewEmptyTitle => 'No reviews for today';

  @override
  String get reviewEmptySubtitle => 'Complete tasks to create review schedules';

  @override
  String get reviewConfidenceTitle => 'How well did you remember?';

  @override
  String get reviewConfidenceVeryHard => 'Very Hard';

  @override
  String get reviewConfidenceHard => 'Hard';

  @override
  String get reviewConfidenceMedium => 'Medium';

  @override
  String get reviewConfidenceEasy => 'Easy';

  @override
  String get reviewConfidenceVeryEasy => 'Very Easy';

  @override
  String reviewItemCount(Object reviewCount) {
    return 'Review $reviewCount';
  }

  @override
  String get habitsAppBarTitle => 'Habits';

  @override
  String get habitsEmptyTitle => 'No habits yet';

  @override
  String get habitsEmptySubtitle => 'Create a habit to track';

  @override
  String get habitsHintName => 'New habit name...';

  @override
  String get habitsButtonAdd => 'Add Habit';

  @override
  String get pomodoroAppBarTitle => 'Pomodoro';

  @override
  String get pomodoroStatSession => 'Session';

  @override
  String get pomodoroStatFocus => 'Focus';

  @override
  String get pomodoroLabelFocus => 'FOCUS';

  @override
  String get pomodoroLabelShortBreak => 'SHORT BREAK';

  @override
  String get pomodoroLabelLongBreak => 'LONG BREAK';

  @override
  String get aiPlannerAppBarTitle => 'AI Study Planner';

  @override
  String get aiPlannerCardTitle => 'AI Study Plan Generator';

  @override
  String get aiPlannerCardDescription => 'Describe your study goal and AI will create a personalized plan.';

  @override
  String get aiPlannerFieldGoal => 'Study Goal';

  @override
  String get aiPlannerHintGoal => 'e.g., Pass JLPT N3 in 3 months';

  @override
  String get aiPlannerFieldSubject => 'Subject';

  @override
  String get aiPlannerHintSubject => 'Select subject';

  @override
  String get aiPlannerFieldDailyTime => 'Daily Study Time';

  @override
  String get aiPlannerMinLabel => 'min';

  @override
  String get aiPlannerFieldDifficulty => 'Difficulty';

  @override
  String get aiPlannerDifficultyBeginner => 'Beginner';

  @override
  String get aiPlannerDifficultyIntermediate => 'Intermediate';

  @override
  String get aiPlannerDifficultyAdvanced => 'Advanced';

  @override
  String get aiPlannerFieldNotes => 'Concerns / Notes';

  @override
  String get aiPlannerHintNotes => 'Any specific areas you want to focus on?';

  @override
  String get aiPlannerButtonGenerate => 'Generate Study Plan';

  @override
  String get aiPlannerButtonGenerating => 'Generating...';

  @override
  String get aiPlannerSuccessTitle => 'Study Plan Generated';

  @override
  String get aiPlannerSectionToday => 'Today\'s Tasks';

  @override
  String get aiPlannerSectionWeek => 'This Week';

  @override
  String get aiPlannerButtonAddTasks => 'Add to Tasks';

  @override
  String get aiPlannerTasksAdded => 'Tasks added!';

  @override
  String get aiPlannerButtonGenerateAgain => 'Generate Again';

  @override
  String get calendarAppBarTitle => 'Calendar Sync';

  @override
  String get calendarListTileTitle => 'Google Calendar';

  @override
  String get calendarListTileSubtitle => 'Sync your tasks as calendar events';

  @override
  String get calendarButtonGenerate => 'Suggest Events from Tasks';

  @override
  String get calendarButtonGenerating => 'Generating...';

  @override
  String get calendarSectionDrafts => 'Event Drafts';

  @override
  String get calendarEmptyDrafts => 'No event drafts generated';

  @override
  String get calendarEventRegistered => 'Event registered successfully!';

  @override
  String get calendarTimeSeparator => ' - ';

  @override
  String get calendarButtonCancel => 'Cancel';

  @override
  String get calendarButtonEdit => 'Edit';

  @override
  String get calendarButtonRegister => 'Register';

  @override
  String get driveAppBarTitle => 'Drive Sync';

  @override
  String get driveStatusReady => 'Ready';

  @override
  String get driveStatusChecking => 'Checking...';

  @override
  String get driveStatusError => 'Error';

  @override
  String get driveSectionAbout => 'About Google Drive Sync';

  @override
  String get driveDescription => 'Your data is backed up to a private app folder in Google Drive, invisible to other users. You can restore your data anytime from any device.';

  @override
  String get driveBackupSuccess => 'Backup completed successfully!';

  @override
  String get driveRestoreTitle => 'Restore Data?';

  @override
  String get driveRestoreMessage => 'This will replace your current data with the backup. Continue?';

  @override
  String get driveButtonCancel => 'Cancel';

  @override
  String get driveButtonRestore => 'Restore';

  @override
  String get driveRestoreSuccess => 'Data restored successfully!';

  @override
  String get driveNoBackup => 'No backup found';

  @override
  String get settingsAppBarTitle => 'Settings';

  @override
  String get settingsSectionAppearance => 'Appearance';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsDarkModeSubtitle => 'Toggle dark theme';

  @override
  String get settingsSectionData => 'Data';

  @override
  String get settingsBackupDrive => 'Backup to Drive';

  @override
  String get settingsBackupDriveSubtitle => 'Manual backup';

  @override
  String get settingsRestoreDrive => 'Restore from Drive';

  @override
  String get settingsRestoreDriveSubtitle => 'Manual restore';

  @override
  String get settingsSectionAIPrivacy => 'AI Privacy';

  @override
  String get settingsDataSentToAI => 'Data sent to AI';

  @override
  String get settingsAIPrivacyDescription => 'When using AI features, your study goals and task descriptions may be sent to an AI service for processing. No personally identifiable information is stored.';

  @override
  String get settingsSectionAbout => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsAppName => 'StudyFlow AI';

  @override
  String get settingsAppDescription => 'AI-powered study assistant';

  @override
  String get aiSuggestionCardTitle => 'AI Suggestion';

  @override
  String get aiSuggestionDismiss => 'Dismiss';

  @override
  String get aiSuggestionApply => 'Apply';

  @override
  String get driveSyncCardTitle => 'Google Drive Sync';

  @override
  String get driveSyncLastSynced => 'Last synced: ';

  @override
  String get driveSyncButtonBackup => 'Backup';

  @override
  String get driveSyncButtonRestore => 'Restore';

  @override
  String get errorNetwork => 'Network error occurred';

  @override
  String get errorAuth => 'Authentication error';

  @override
  String get errorValidation => 'Validation error';

  @override
  String get errorDatabase => 'Database error';

  @override
  String get errorAI => 'AI API error';

  @override
  String get errorCalendar => 'Calendar API error';

  @override
  String get errorDrive => 'Drive API error';

  @override
  String get errorNotification => 'Notification error';

  @override
  String get errorUnknown => 'Unknown error';

  @override
  String get smallStepsAppBar => 'Small Steps';

  @override
  String get smallStepsProgress => 'Progress:';

  @override
  String get smallStepsHint => 'Enter a small step...';

  @override
  String get smallStepsAdd => 'Add Step';

  @override
  String get smallStepsEmpty => 'No steps yet. Break down your task!';

  @override
  String get smallStepsBreakDown => 'Break Down';

  @override
  String get smallStepsAiSuggest => 'Let AI suggest small steps';

  @override
  String get smallStepsAiBreakdown => 'AI Breakdown';

  @override
  String get smallStepsAdded => 'Steps added to task!';

  @override
  String get taskBreakdownSuggestion => 'Break this task into small steps to make it more manageable. Small steps build momentum!';
}
