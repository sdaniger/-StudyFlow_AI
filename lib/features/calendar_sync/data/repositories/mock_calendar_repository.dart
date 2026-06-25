import 'package:uuid/uuid.dart';
import '../../domain/entities/calendar_event_draft.dart';
import '../../domain/entities/calendar_sync_result.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../../../../core/result/app_result.dart';
import '../../../tasks/domain/entities/task.dart';

class MockCalendarRepository implements CalendarRepository {
  static const _uuid = Uuid();

  @override
  Future<AppResult<List<CalendarEventDraft>>> suggestEventsFromTasks(
      List<Task> tasks) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final now = DateTime.now();
    final drafts = tasks
        .where((t) => t.dueDate != null)
        .map((task) => CalendarEventDraft(
              id: _uuid.v4(),
              taskId: task.id,
              title: task.title,
              description: task.description,
              startAt: task.dueDate!,
              endAt: task.dueDate!.add(const Duration(hours: 1)),
              timezone: 'UTC',
              reminderMinutes: 10,
              createdAt: now,
              updatedAt: now,
            ))
        .toList();

    if (drafts.isEmpty) {
      return AppSuccess([
        CalendarEventDraft(
          id: _uuid.v4(),
          taskId: null,
          title: 'Study Session',
          description: 'Review and practice',
          startAt: now.add(const Duration(days: 1)),
          endAt: now.add(const Duration(days: 1)).add(const Duration(hours: 2)),
          timezone: 'UTC',
          reminderMinutes: 15,
          createdAt: now,
          updatedAt: now,
        ),
      ]);
    }

    return AppSuccess(drafts);
  }

  @override
  Future<AppResult<CalendarSyncResult>> createEvent(
      CalendarEventDraft draft) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return AppSuccess(
      CalendarSyncResult(
        success: true,
        eventId: _uuid.v4(),
      ),
    );
  }

  @override
  Future<AppResult<CalendarSyncResult>> updateEvent(
      String eventId, CalendarEventDraft draft) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return AppSuccess(
      CalendarSyncResult(success: true, eventId: eventId),
    );
  }

  @override
  Future<AppResult<void>> deleteEvent(String eventId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const AppSuccess(null);
  }
}
