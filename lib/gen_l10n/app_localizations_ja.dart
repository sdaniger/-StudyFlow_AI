import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'StudyFlow AI';

  @override
  String get appVersion => '1.0.0';

  @override
  String get navHome => 'ホーム';

  @override
  String get navTasks => 'タスク';

  @override
  String get navFocus => '集中';

  @override
  String get navHabits => '習慣';

  @override
  String get navReview => '復習';

  @override
  String get navAI => 'AI';

  @override
  String get navCalendar => 'カレンダー';

  @override
  String get navDrive => 'ドライブ';

  @override
  String get navSettings => '設定';

  @override
  String get homeAppBarTitle => 'StudyFlow AI';

  @override
  String get homeAISuggestion => '英単語の復習を先に終わらせると、午後の数学に集中しやすくなります。';

  @override
  String get homeTodayTasks => '今日のタスク';

  @override
  String get homeViewAll => 'すべて表示';

  @override
  String get homeStatCompleted => '完了';

  @override
  String get homeStatFocusTime => '集中時間';

  @override
  String get homeStatFocusTimeDefault => '0分';

  @override
  String get homeNoTasks => '今日のタスクはありません。追加しましょう！';

  @override
  String get tasksAppBarTitle => 'タスク';

  @override
  String get tasksEmptyTitle => 'タスクがありません';

  @override
  String get tasksEmptySubtitle => 'タスクを追加して始めましょう';

  @override
  String get tasksError => 'エラー: ';

  @override
  String get tasksUnexpectedState => '予期しない状態です';

  @override
  String get taskEditAppBarNew => '新規タスク';

  @override
  String get taskEditFieldTitle => 'タイトル';

  @override
  String get taskEditHintTitle => '何を勉強しますか？';

  @override
  String get taskEditFieldDescription => '説明';

  @override
  String get taskEditHintDescription => '詳細を追加...';

  @override
  String get taskEditFieldSubject => '科目';

  @override
  String get taskEditHintSubject => '科目を選択';

  @override
  String get taskEditFieldPriority => '優先度';

  @override
  String get taskEditFieldDueDate => '期限';

  @override
  String get taskEditPlaceholderDueDate => '期限を設定';

  @override
  String get taskEditButtonCreate => 'タスクを作成';

  @override
  String get subjectEnglish => '英語';

  @override
  String get subjectMathematics => '数学';

  @override
  String get subjectPhysics => '物理';

  @override
  String get subjectChemistry => '化学';

  @override
  String get subjectBiology => '生物';

  @override
  String get subjectHistory => '歴史';

  @override
  String get subjectGeography => '地理';

  @override
  String get subjectLiterature => '文学';

  @override
  String get subjectProgramming => 'プログラミング';

  @override
  String get subjectOther => 'その他';

  @override
  String get priorityLow => '低';

  @override
  String get priorityMedium => '中';

  @override
  String get priorityHigh => '高';

  @override
  String get priorityUrgent => '緊急';

  @override
  String get statusTodo => '未着手';

  @override
  String get statusInProgress => '進行中';

  @override
  String get statusDone => '完了';

  @override
  String get statusArchived => 'アーカイブ';

  @override
  String get habitFrequencyDaily => '毎日';

  @override
  String get habitFrequencyWeekly => '毎週';

  @override
  String get habitFrequencyWeekday => '平日';

  @override
  String get habitFrequencyWeekend => '週末';

  @override
  String get pomodoroModeFocus => '集中';

  @override
  String get pomodoroModeShortBreak => '短い休憩';

  @override
  String get pomodoroModeLongBreak => '長い休憩';

  @override
  String get reviewStatusScheduled => '予定';

  @override
  String get reviewStatusDone => '完了';

  @override
  String get reviewStatusSkipped => 'スキップ';

  @override
  String get reviewStatusArchived => 'アーカイブ';

  @override
  String get reviewAppBarTitle => '復習';

  @override
  String get reviewEmptyTitle => '今日の復習はありません';

  @override
  String get reviewEmptySubtitle => 'タスクを完了すると復習スケジュールが作成されます';

  @override
  String get reviewConfidenceTitle => 'どのくらい覚えていましたか？';

  @override
  String get reviewConfidenceVeryHard => 'とても難しい';

  @override
  String get reviewConfidenceHard => '難しい';

  @override
  String get reviewConfidenceMedium => '普通';

  @override
  String get reviewConfidenceEasy => '簡単';

  @override
  String get reviewConfidenceVeryEasy => 'とても簡単';

  @override
  String reviewItemCount(Object reviewCount) {
    return '復習 $reviewCount回目';
  }

  @override
  String get habitsAppBarTitle => '習慣';

  @override
  String get habitsEmptyTitle => '習慣がありません';

  @override
  String get habitsEmptySubtitle => '追跡する習慣を作成しましょう';

  @override
  String get habitsHintName => '新しい習慣名...';

  @override
  String get habitsButtonAdd => '習慣を追加';

  @override
  String get pomodoroAppBarTitle => 'ポモドーロ';

  @override
  String get pomodoroStatSession => 'セッション';

  @override
  String get pomodoroStatFocus => '集中';

  @override
  String get pomodoroLabelFocus => '集中';

  @override
  String get pomodoroLabelShortBreak => '短い休憩';

  @override
  String get pomodoroLabelLongBreak => '長い休憩';

  @override
  String get aiPlannerAppBarTitle => 'AI学習プランナー';

  @override
  String get aiPlannerCardTitle => 'AI学習計画生成';

  @override
  String get aiPlannerCardDescription => '学習目標を説明すると、AIがパーソナライズされた計画を作成します。';

  @override
  String get aiPlannerFieldGoal => '学習目標';

  @override
  String get aiPlannerHintGoal => '例：3ヶ月でJLPT N3に合格';

  @override
  String get aiPlannerFieldSubject => '科目';

  @override
  String get aiPlannerHintSubject => '科目を選択';

  @override
  String get aiPlannerFieldDailyTime => '1日の学習時間';

  @override
  String get aiPlannerMinLabel => '分';

  @override
  String get aiPlannerFieldDifficulty => '難易度';

  @override
  String get aiPlannerDifficultyBeginner => '初心者';

  @override
  String get aiPlannerDifficultyIntermediate => '中級';

  @override
  String get aiPlannerDifficultyAdvanced => '上級';

  @override
  String get aiPlannerFieldNotes => '懸念事項・メモ';

  @override
  String get aiPlannerHintNotes => '特に集中したい分野はありますか？';

  @override
  String get aiPlannerButtonGenerate => '学習計画を生成';

  @override
  String get aiPlannerButtonGenerating => '生成中...';

  @override
  String get aiPlannerSuccessTitle => '学習計画が生成されました';

  @override
  String get aiPlannerSectionToday => '今日のタスク';

  @override
  String get aiPlannerSectionWeek => '今週';

  @override
  String get aiPlannerButtonAddTasks => 'タスクに追加';

  @override
  String get aiPlannerTasksAdded => 'タスクを追加しました！';

  @override
  String get aiPlannerButtonGenerateAgain => '再生成';

  @override
  String get calendarAppBarTitle => 'カレンダー同期';

  @override
  String get calendarListTileTitle => 'Googleカレンダー';

  @override
  String get calendarListTileSubtitle => 'タスクをカレンダーイベントとして同期';

  @override
  String get calendarButtonGenerate => 'タスクからイベントを提案';

  @override
  String get calendarButtonGenerating => '生成中...';

  @override
  String get calendarSectionDrafts => 'イベント下書き';

  @override
  String get calendarEmptyDrafts => '生成されたイベントはありません';

  @override
  String get calendarEventRegistered => 'イベントを登録しました！';

  @override
  String get calendarTimeSeparator => ' ～ ';

  @override
  String get calendarButtonCancel => 'キャンセル';

  @override
  String get calendarButtonEdit => '編集';

  @override
  String get calendarButtonRegister => '登録';

  @override
  String get driveAppBarTitle => 'ドライブ同期';

  @override
  String get driveStatusReady => '準備完了';

  @override
  String get driveStatusChecking => '確認中...';

  @override
  String get driveStatusError => 'エラー';

  @override
  String get driveSectionAbout => 'Googleドライブ同期について';

  @override
  String get driveDescription => 'データはGoogleドライブのプライベートアプリフォルダにバックアップされ、他のユーザーからは見えません。いつでもどのデバイスからでも復元できます。';

  @override
  String get driveBackupSuccess => 'バックアップが完了しました！';

  @override
  String get driveRestoreTitle => 'データを復元しますか？';

  @override
  String get driveRestoreMessage => '現在のデータがバックアップと置き換えられます。続行しますか？';

  @override
  String get driveButtonCancel => 'キャンセル';

  @override
  String get driveButtonRestore => '復元';

  @override
  String get driveRestoreSuccess => 'データを復元しました！';

  @override
  String get driveNoBackup => 'バックアップが見つかりません';

  @override
  String get settingsAppBarTitle => '設定';

  @override
  String get settingsSectionAppearance => '外観';

  @override
  String get settingsDarkMode => 'ダークモード';

  @override
  String get settingsDarkModeSubtitle => 'ダークテーマに切り替え';

  @override
  String get settingsSectionData => 'データ';

  @override
  String get settingsBackupDrive => 'ドライブにバックアップ';

  @override
  String get settingsBackupDriveSubtitle => '手動バックアップ';

  @override
  String get settingsRestoreDrive => 'ドライブから復元';

  @override
  String get settingsRestoreDriveSubtitle => '手動復元';

  @override
  String get settingsSectionAIPrivacy => 'AIプライバシー';

  @override
  String get settingsDataSentToAI => 'AIに送信されるデータ';

  @override
  String get settingsAIPrivacyDescription => 'AI機能を使用する際、学習目標やタスクの説明がAIサービスに送信される場合があります。個人を特定できる情報は保存されません。';

  @override
  String get settingsSectionAbout => 'このアプリについて';

  @override
  String get settingsVersion => 'バージョン';

  @override
  String get settingsAppName => 'StudyFlow AI';

  @override
  String get settingsAppDescription => 'AI搭載学習アシスタント';

  @override
  String get settingsSectionAi => 'AI設定';

  @override
  String get settingsApiKeyGemini => 'Gemini API キー';

  @override
  String get settingsApiKeyOpenRouter => 'OpenRouter API キー';

  @override
  String get settingsApiKeySave => '保存';

  @override
  String get settingsApiKeySaved => 'API キーを保存しました！';

  @override
  String get quickTaskHint => '例：明日2時間、第5章を勉強する';

  @override
  String get quickTaskAskAi => 'AIに質問';

  @override
  String quickTaskResult(Object count) {
    return '$count件のタスクを作成しました';
  }

  @override
  String get aiSuggestionCardTitle => 'AI提案';

  @override
  String get aiSuggestionDismiss => '閉じる';

  @override
  String get aiSuggestionApply => '適用';

  @override
  String get driveSyncCardTitle => 'Googleドライブ同期';

  @override
  String get driveSyncLastSynced => '最終同期: ';

  @override
  String get driveSyncButtonBackup => 'バックアップ';

  @override
  String get driveSyncButtonRestore => '復元';

  @override
  String get errorNetwork => 'ネットワークエラーが発生しました';

  @override
  String get errorAuth => '認証エラー';

  @override
  String get errorValidation => 'バリデーションエラー';

  @override
  String get errorDatabase => 'データベースエラー';

  @override
  String get errorAI => 'AI APIエラー';

  @override
  String get errorCalendar => 'カレンダーAPIエラー';

  @override
  String get errorDrive => 'ドライブAPIエラー';

  @override
  String get errorNotification => '通知エラー';

  @override
  String get errorUnknown => '不明なエラー';

  @override
  String get smallStepsAppBar => 'スモールステップ';

  @override
  String get smallStepsProgress => '進捗:';

  @override
  String get smallStepsHint => '小さなステップを入力...';

  @override
  String get smallStepsAdd => '追加';

  @override
  String get smallStepsEmpty => 'まだステップがありません。3つに分解してみましょう！';

  @override
  String get smallStepsBreakDown => '分解する';

  @override
  String get smallStepsAiSuggest => 'AIに小さなステップを提案させる';

  @override
  String get smallStepsAiBreakdown => 'AIで分解';

  @override
  String get smallStepsAdded => 'タスクにステップを追加しました！';

  @override
  String get smallStepTileTooltip => '3つに分解';

  @override
  String smallStepCountBadge(Object count) {
    return 'ステップ $count';
  }

  @override
  String get smallStepEditHint => 'ステップを編集';

  @override
  String get smallStepEditSave => '保存';

  @override
  String get smallStepEditCancel => 'キャンセル';

  @override
  String get smallStepAiBreakdownToast => 'AI分解は近日公開予定！';

  @override
  String get taskBreakdownSuggestion => 'このタスクを小さなステップに分解すると、より取り組みやすくなります。小さなステップが勢いを作ります！';
}
