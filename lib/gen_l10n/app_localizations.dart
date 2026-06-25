import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'StudyFlow AI'**
  String get appTitle;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'1.0.0'**
  String get appVersion;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get navTasks;

  /// No description provided for @navFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get navFocus;

  /// No description provided for @navHabits.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get navHabits;

  /// No description provided for @navReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get navReview;

  /// No description provided for @navAI.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get navAI;

  /// No description provided for @navCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get navCalendar;

  /// No description provided for @navDrive.
  ///
  /// In en, this message translates to:
  /// **'Drive'**
  String get navDrive;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @homeAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'StudyFlow AI'**
  String get homeAppBarTitle;

  /// No description provided for @homeAISuggestion.
  ///
  /// In en, this message translates to:
  /// **'Finish reviewing English vocabulary first, then you can focus better on afternoon math.'**
  String get homeAISuggestion;

  /// No description provided for @homeTodayTasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Tasks'**
  String get homeTodayTasks;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeViewAll;

  /// No description provided for @homeStatCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get homeStatCompleted;

  /// No description provided for @homeStatFocusTime.
  ///
  /// In en, this message translates to:
  /// **'Focus Time'**
  String get homeStatFocusTime;

  /// No description provided for @homeStatFocusTimeDefault.
  ///
  /// In en, this message translates to:
  /// **'0m'**
  String get homeStatFocusTimeDefault;

  /// No description provided for @homeNoTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks for today. Add one!'**
  String get homeNoTasks;

  /// No description provided for @tasksAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasksAppBarTitle;

  /// No description provided for @tasksEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet'**
  String get tasksEmptyTitle;

  /// No description provided for @tasksEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a task to get started'**
  String get tasksEmptySubtitle;

  /// No description provided for @tasksError.
  ///
  /// In en, this message translates to:
  /// **'Error: '**
  String get tasksError;

  /// No description provided for @tasksUnexpectedState.
  ///
  /// In en, this message translates to:
  /// **'Unexpected state'**
  String get tasksUnexpectedState;

  /// No description provided for @taskEditAppBarNew.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get taskEditAppBarNew;

  /// No description provided for @taskEditFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get taskEditFieldTitle;

  /// No description provided for @taskEditHintTitle.
  ///
  /// In en, this message translates to:
  /// **'What do you want to study?'**
  String get taskEditHintTitle;

  /// No description provided for @taskEditFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get taskEditFieldDescription;

  /// No description provided for @taskEditHintDescription.
  ///
  /// In en, this message translates to:
  /// **'Add details...'**
  String get taskEditHintDescription;

  /// No description provided for @taskEditFieldSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get taskEditFieldSubject;

  /// No description provided for @taskEditHintSubject.
  ///
  /// In en, this message translates to:
  /// **'Select subject'**
  String get taskEditHintSubject;

  /// No description provided for @taskEditFieldPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get taskEditFieldPriority;

  /// No description provided for @taskEditFieldDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get taskEditFieldDueDate;

  /// No description provided for @taskEditPlaceholderDueDate.
  ///
  /// In en, this message translates to:
  /// **'Set due date'**
  String get taskEditPlaceholderDueDate;

  /// No description provided for @taskEditButtonCreate.
  ///
  /// In en, this message translates to:
  /// **'Create Task'**
  String get taskEditButtonCreate;

  /// No description provided for @subjectEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get subjectEnglish;

  /// No description provided for @subjectMathematics.
  ///
  /// In en, this message translates to:
  /// **'Mathematics'**
  String get subjectMathematics;

  /// No description provided for @subjectPhysics.
  ///
  /// In en, this message translates to:
  /// **'Physics'**
  String get subjectPhysics;

  /// No description provided for @subjectChemistry.
  ///
  /// In en, this message translates to:
  /// **'Chemistry'**
  String get subjectChemistry;

  /// No description provided for @subjectBiology.
  ///
  /// In en, this message translates to:
  /// **'Biology'**
  String get subjectBiology;

  /// No description provided for @subjectHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get subjectHistory;

  /// No description provided for @subjectGeography.
  ///
  /// In en, this message translates to:
  /// **'Geography'**
  String get subjectGeography;

  /// No description provided for @subjectLiterature.
  ///
  /// In en, this message translates to:
  /// **'Literature'**
  String get subjectLiterature;

  /// No description provided for @subjectProgramming.
  ///
  /// In en, this message translates to:
  /// **'Programming'**
  String get subjectProgramming;

  /// No description provided for @subjectOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get subjectOther;

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priorityLow;

  /// No description provided for @priorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get priorityMedium;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get priorityHigh;

  /// No description provided for @priorityUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get priorityUrgent;

  /// No description provided for @statusTodo.
  ///
  /// In en, this message translates to:
  /// **'To Do'**
  String get statusTodo;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get statusInProgress;

  /// No description provided for @statusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get statusDone;

  /// No description provided for @statusArchived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get statusArchived;

  /// No description provided for @habitFrequencyDaily.
  ///
  /// In en, this message translates to:
  /// **'Every Day'**
  String get habitFrequencyDaily;

  /// No description provided for @habitFrequencyWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get habitFrequencyWeekly;

  /// No description provided for @habitFrequencyWeekday.
  ///
  /// In en, this message translates to:
  /// **'Weekdays'**
  String get habitFrequencyWeekday;

  /// No description provided for @habitFrequencyWeekend.
  ///
  /// In en, this message translates to:
  /// **'Weekends'**
  String get habitFrequencyWeekend;

  /// No description provided for @pomodoroModeFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get pomodoroModeFocus;

  /// No description provided for @pomodoroModeShortBreak.
  ///
  /// In en, this message translates to:
  /// **'Short Break'**
  String get pomodoroModeShortBreak;

  /// No description provided for @pomodoroModeLongBreak.
  ///
  /// In en, this message translates to:
  /// **'Long Break'**
  String get pomodoroModeLongBreak;

  /// No description provided for @reviewStatusScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get reviewStatusScheduled;

  /// No description provided for @reviewStatusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get reviewStatusDone;

  /// No description provided for @reviewStatusSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get reviewStatusSkipped;

  /// No description provided for @reviewStatusArchived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get reviewStatusArchived;

  /// No description provided for @reviewAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get reviewAppBarTitle;

  /// No description provided for @reviewEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No reviews for today'**
  String get reviewEmptyTitle;

  /// No description provided for @reviewEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete tasks to create review schedules'**
  String get reviewEmptySubtitle;

  /// No description provided for @reviewConfidenceTitle.
  ///
  /// In en, this message translates to:
  /// **'How well did you remember?'**
  String get reviewConfidenceTitle;

  /// No description provided for @reviewConfidenceVeryHard.
  ///
  /// In en, this message translates to:
  /// **'Very Hard'**
  String get reviewConfidenceVeryHard;

  /// No description provided for @reviewConfidenceHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get reviewConfidenceHard;

  /// No description provided for @reviewConfidenceMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get reviewConfidenceMedium;

  /// No description provided for @reviewConfidenceEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get reviewConfidenceEasy;

  /// No description provided for @reviewConfidenceVeryEasy.
  ///
  /// In en, this message translates to:
  /// **'Very Easy'**
  String get reviewConfidenceVeryEasy;

  /// No description provided for @reviewItemCount.
  ///
  /// In en, this message translates to:
  /// **'Review {reviewCount}'**
  String reviewItemCount(Object reviewCount);

  /// No description provided for @habitsAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get habitsAppBarTitle;

  /// No description provided for @habitsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No habits yet'**
  String get habitsEmptyTitle;

  /// No description provided for @habitsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a habit to track'**
  String get habitsEmptySubtitle;

  /// No description provided for @habitsHintName.
  ///
  /// In en, this message translates to:
  /// **'New habit name...'**
  String get habitsHintName;

  /// No description provided for @habitsButtonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Habit'**
  String get habitsButtonAdd;

  /// No description provided for @pomodoroAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Pomodoro'**
  String get pomodoroAppBarTitle;

  /// No description provided for @pomodoroStatSession.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get pomodoroStatSession;

  /// No description provided for @pomodoroStatFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get pomodoroStatFocus;

  /// No description provided for @pomodoroLabelFocus.
  ///
  /// In en, this message translates to:
  /// **'FOCUS'**
  String get pomodoroLabelFocus;

  /// No description provided for @pomodoroLabelShortBreak.
  ///
  /// In en, this message translates to:
  /// **'SHORT BREAK'**
  String get pomodoroLabelShortBreak;

  /// No description provided for @pomodoroLabelLongBreak.
  ///
  /// In en, this message translates to:
  /// **'LONG BREAK'**
  String get pomodoroLabelLongBreak;

  /// No description provided for @aiPlannerAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Study Planner'**
  String get aiPlannerAppBarTitle;

  /// No description provided for @aiPlannerCardTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Study Plan Generator'**
  String get aiPlannerCardTitle;

  /// No description provided for @aiPlannerCardDescription.
  ///
  /// In en, this message translates to:
  /// **'Describe your study goal and AI will create a personalized plan.'**
  String get aiPlannerCardDescription;

  /// No description provided for @aiPlannerFieldGoal.
  ///
  /// In en, this message translates to:
  /// **'Study Goal'**
  String get aiPlannerFieldGoal;

  /// No description provided for @aiPlannerHintGoal.
  ///
  /// In en, this message translates to:
  /// **'e.g., Pass JLPT N3 in 3 months'**
  String get aiPlannerHintGoal;

  /// No description provided for @aiPlannerFieldSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get aiPlannerFieldSubject;

  /// No description provided for @aiPlannerHintSubject.
  ///
  /// In en, this message translates to:
  /// **'Select subject'**
  String get aiPlannerHintSubject;

  /// No description provided for @aiPlannerFieldDailyTime.
  ///
  /// In en, this message translates to:
  /// **'Daily Study Time'**
  String get aiPlannerFieldDailyTime;

  /// No description provided for @aiPlannerMinLabel.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get aiPlannerMinLabel;

  /// No description provided for @aiPlannerFieldDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get aiPlannerFieldDifficulty;

  /// No description provided for @aiPlannerDifficultyBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get aiPlannerDifficultyBeginner;

  /// No description provided for @aiPlannerDifficultyIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get aiPlannerDifficultyIntermediate;

  /// No description provided for @aiPlannerDifficultyAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get aiPlannerDifficultyAdvanced;

  /// No description provided for @aiPlannerFieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Concerns / Notes'**
  String get aiPlannerFieldNotes;

  /// No description provided for @aiPlannerHintNotes.
  ///
  /// In en, this message translates to:
  /// **'Any specific areas you want to focus on?'**
  String get aiPlannerHintNotes;

  /// No description provided for @aiPlannerButtonGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate Study Plan'**
  String get aiPlannerButtonGenerate;

  /// No description provided for @aiPlannerButtonGenerating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get aiPlannerButtonGenerating;

  /// No description provided for @aiPlannerSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Study Plan Generated'**
  String get aiPlannerSuccessTitle;

  /// No description provided for @aiPlannerSectionToday.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Tasks'**
  String get aiPlannerSectionToday;

  /// No description provided for @aiPlannerSectionWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get aiPlannerSectionWeek;

  /// No description provided for @aiPlannerButtonAddTasks.
  ///
  /// In en, this message translates to:
  /// **'Add to Tasks'**
  String get aiPlannerButtonAddTasks;

  /// No description provided for @aiPlannerTasksAdded.
  ///
  /// In en, this message translates to:
  /// **'Tasks added!'**
  String get aiPlannerTasksAdded;

  /// No description provided for @aiPlannerButtonGenerateAgain.
  ///
  /// In en, this message translates to:
  /// **'Generate Again'**
  String get aiPlannerButtonGenerateAgain;

  /// No description provided for @calendarAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar Sync'**
  String get calendarAppBarTitle;

  /// No description provided for @calendarListTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Google Calendar'**
  String get calendarListTileTitle;

  /// No description provided for @calendarListTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sync your tasks as calendar events'**
  String get calendarListTileSubtitle;

  /// No description provided for @calendarButtonGenerate.
  ///
  /// In en, this message translates to:
  /// **'Suggest Events from Tasks'**
  String get calendarButtonGenerate;

  /// No description provided for @calendarButtonGenerating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get calendarButtonGenerating;

  /// No description provided for @calendarSectionDrafts.
  ///
  /// In en, this message translates to:
  /// **'Event Drafts'**
  String get calendarSectionDrafts;

  /// No description provided for @calendarEmptyDrafts.
  ///
  /// In en, this message translates to:
  /// **'No event drafts generated'**
  String get calendarEmptyDrafts;

  /// No description provided for @calendarEventRegistered.
  ///
  /// In en, this message translates to:
  /// **'Event registered successfully!'**
  String get calendarEventRegistered;

  /// No description provided for @calendarTimeSeparator.
  ///
  /// In en, this message translates to:
  /// **' - '**
  String get calendarTimeSeparator;

  /// No description provided for @calendarButtonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get calendarButtonCancel;

  /// No description provided for @calendarButtonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get calendarButtonEdit;

  /// No description provided for @calendarButtonRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get calendarButtonRegister;

  /// No description provided for @driveAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Drive Sync'**
  String get driveAppBarTitle;

  /// No description provided for @driveStatusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get driveStatusReady;

  /// No description provided for @driveStatusChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get driveStatusChecking;

  /// No description provided for @driveStatusError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get driveStatusError;

  /// No description provided for @driveSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About Google Drive Sync'**
  String get driveSectionAbout;

  /// No description provided for @driveDescription.
  ///
  /// In en, this message translates to:
  /// **'Your data is backed up to a private app folder in Google Drive, invisible to other users. You can restore your data anytime from any device.'**
  String get driveDescription;

  /// No description provided for @driveBackupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup completed successfully!'**
  String get driveBackupSuccess;

  /// No description provided for @driveRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore Data?'**
  String get driveRestoreTitle;

  /// No description provided for @driveRestoreMessage.
  ///
  /// In en, this message translates to:
  /// **'This will replace your current data with the backup. Continue?'**
  String get driveRestoreMessage;

  /// No description provided for @driveButtonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get driveButtonCancel;

  /// No description provided for @driveButtonRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get driveButtonRestore;

  /// No description provided for @driveRestoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data restored successfully!'**
  String get driveRestoreSuccess;

  /// No description provided for @driveNoBackup.
  ///
  /// In en, this message translates to:
  /// **'No backup found'**
  String get driveNoBackup;

  /// No description provided for @settingsAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsAppBarTitle;

  /// No description provided for @settingsSectionAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsSectionAppearance;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsDarkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Toggle dark theme'**
  String get settingsDarkModeSubtitle;

  /// No description provided for @settingsSectionData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsSectionData;

  /// No description provided for @settingsBackupDrive.
  ///
  /// In en, this message translates to:
  /// **'Backup to Drive'**
  String get settingsBackupDrive;

  /// No description provided for @settingsBackupDriveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manual backup'**
  String get settingsBackupDriveSubtitle;

  /// No description provided for @settingsRestoreDrive.
  ///
  /// In en, this message translates to:
  /// **'Restore from Drive'**
  String get settingsRestoreDrive;

  /// No description provided for @settingsRestoreDriveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manual restore'**
  String get settingsRestoreDriveSubtitle;

  /// No description provided for @settingsSectionAIPrivacy.
  ///
  /// In en, this message translates to:
  /// **'AI Privacy'**
  String get settingsSectionAIPrivacy;

  /// No description provided for @settingsDataSentToAI.
  ///
  /// In en, this message translates to:
  /// **'Data sent to AI'**
  String get settingsDataSentToAI;

  /// No description provided for @settingsAIPrivacyDescription.
  ///
  /// In en, this message translates to:
  /// **'When using AI features, your study goals and task descriptions may be sent to an AI service for processing. No personally identifiable information is stored.'**
  String get settingsAIPrivacyDescription;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsSectionAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsAppName.
  ///
  /// In en, this message translates to:
  /// **'StudyFlow AI'**
  String get settingsAppName;

  /// No description provided for @settingsAppDescription.
  ///
  /// In en, this message translates to:
  /// **'AI-powered study assistant'**
  String get settingsAppDescription;

  /// No description provided for @aiSuggestionCardTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Suggestion'**
  String get aiSuggestionCardTitle;

  /// No description provided for @aiSuggestionDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get aiSuggestionDismiss;

  /// No description provided for @aiSuggestionApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get aiSuggestionApply;

  /// No description provided for @driveSyncCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Google Drive Sync'**
  String get driveSyncCardTitle;

  /// No description provided for @driveSyncLastSynced.
  ///
  /// In en, this message translates to:
  /// **'Last synced: '**
  String get driveSyncLastSynced;

  /// No description provided for @driveSyncButtonBackup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get driveSyncButtonBackup;

  /// No description provided for @driveSyncButtonRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get driveSyncButtonRestore;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error occurred'**
  String get errorNetwork;

  /// No description provided for @errorAuth.
  ///
  /// In en, this message translates to:
  /// **'Authentication error'**
  String get errorAuth;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Validation error'**
  String get errorValidation;

  /// No description provided for @errorDatabase.
  ///
  /// In en, this message translates to:
  /// **'Database error'**
  String get errorDatabase;

  /// No description provided for @errorAI.
  ///
  /// In en, this message translates to:
  /// **'AI API error'**
  String get errorAI;

  /// No description provided for @errorCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar API error'**
  String get errorCalendar;

  /// No description provided for @errorDrive.
  ///
  /// In en, this message translates to:
  /// **'Drive API error'**
  String get errorDrive;

  /// No description provided for @errorNotification.
  ///
  /// In en, this message translates to:
  /// **'Notification error'**
  String get errorNotification;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get errorUnknown;

  /// No description provided for @smallStepsAppBar.
  ///
  /// In en, this message translates to:
  /// **'Small Steps'**
  String get smallStepsAppBar;

  /// No description provided for @smallStepsProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress:'**
  String get smallStepsProgress;

  /// No description provided for @smallStepsHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a small step...'**
  String get smallStepsHint;

  /// No description provided for @smallStepsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Step'**
  String get smallStepsAdd;

  /// No description provided for @smallStepsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No steps yet. Break down your task!'**
  String get smallStepsEmpty;

  /// No description provided for @smallStepsBreakDown.
  ///
  /// In en, this message translates to:
  /// **'Break Down'**
  String get smallStepsBreakDown;

  /// No description provided for @smallStepsAiSuggest.
  ///
  /// In en, this message translates to:
  /// **'Let AI suggest small steps'**
  String get smallStepsAiSuggest;

  /// No description provided for @smallStepsAiBreakdown.
  ///
  /// In en, this message translates to:
  /// **'AI Breakdown'**
  String get smallStepsAiBreakdown;

  /// No description provided for @smallStepsAdded.
  ///
  /// In en, this message translates to:
  /// **'Steps added to task!'**
  String get smallStepsAdded;

  /// No description provided for @taskBreakdownSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Break this task into small steps to make it more manageable. Small steps build momentum!'**
  String get taskBreakdownSuggestion;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
