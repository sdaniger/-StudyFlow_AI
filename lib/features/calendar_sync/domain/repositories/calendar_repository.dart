import '../../../../core/result/app_result.dart';
import '../entities/calendar_event_draft.dart';
import '../entities/calendar_sync_result.dart';
import '../../../tasks/domain/entities/task.dart';

abstract class CalendarRepository {
  Future<AppResult<List<CalendarEventDraft>>> suggestEventsFromTasks(
      List<Task> tasks);
  Future<AppResult<CalendarSyncResult>> createEvent(
      CalendarEventDraft draft);
  Future<AppResult<CalendarSyncResult>> updateEvent(
      String eventId, CalendarEventDraft draft);
  Future<AppResult<void>> deleteEvent(String eventId);
}
