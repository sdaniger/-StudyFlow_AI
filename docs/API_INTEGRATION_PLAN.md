# API Integration Plan

## AI API Integration

### Interface
```dart
abstract class AiPlannerRepository {
  Future<AppResult<StudyPlan>> generateStudyPlan(StudyPlanRequest request);
  Future<AppResult<List<Task>>> decomposeGoal(GoalDecompositionRequest request);
  Future<AppResult<List<ScheduleSuggestion>>> suggestSchedule(
    ScheduleSuggestionRequest request,
  );
}
```

### Implementation Plan
1. Swap `MockAiPlannerRepository` for `OpenAiPlannerRepository`
2. Use HTTP client (dio/http) to call OpenAI/Azure/Gemini API
3. Parse responses into domain entities
4. API key managed via env/secure storage (never in source)

### Safety Rules
- AI suggestions must be previewed by user before saving
- Never send personal data to AI
- User must explicitly approve all AI-generated content

## Google Calendar API

### Interface
```dart
abstract class CalendarRepository {
  Future<AppResult<List<CalendarEventDraft>>> suggestEventsFromTasks(List<Task> tasks);
  Future<AppResult<CalendarSyncResult>> createEvent(CalendarEventDraft draft);
  Future<AppResult<CalendarSyncResult>> updateEvent(String eventId, CalendarEventDraft draft);
  Future<AppResult<void>> deleteEvent(String eventId);
}
```

### Implementation Plan
1. OAuth 2.0 flow (google_sign_in or googleapis packages)
2. Use `calendar.events.insert` API
3. Store `googleEventId` in `CalendarSyncRecord` for future updates
4. User confirms before any calendar write operation

## Google Drive appDataFolder

### Interface
```dart
abstract class DriveSyncRepository {
  Future<AppResult<DriveBackupResult>> backupAppData(AppBackupData data);
  Future<AppResult<AppBackupData?>> restoreAppData();
  Future<AppResult<DriveSyncStatus>> getSyncStatus();
}
```

### Implementation Plan
1. OAuth 2.0 with Drive API scope
2. `appDataFolder` for app-private storage
3. JSON serialization of `AppBackupData`
4. Conflict resolution using `updatedAt` timestamps

## OAuth Strategy
- Use `google_sign_in` package for authentication
- Scoped to Calendar + Drive APIs
- Token management via secure storage
- Refresh token handling

## API Key Management
- Never hardcode API keys in source
- Use `--dart-define` during build or `.env` file
- `SecureConfig` class for centralized key access
- Future: flutter_dotenv or Firebase Remote Config
