import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/calendar_event_draft.dart';
import '../../domain/entities/calendar_sync_result.dart';
import '../../application/providers/calendar_sync_providers.dart';
import '../../../../core/result/app_result.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/application/providers/task_providers.dart';

class CalendarSyncController {
  final Ref _ref;

  CalendarSyncController(this._ref);

  Future<AppResult<List<CalendarEventDraft>>> suggestEvents() async {
    final repo = _ref.read(calendarRepositoryProvider);
    final tasksResult = await _ref.read(taskRepositoryProvider).getAll();

    if (tasksResult is AppSuccess<List<Task>>) {
      return repo.suggestEventsFromTasks(tasksResult.data);
    }
    return repo.suggestEventsFromTasks([]);
  }

  Future<AppResult<CalendarSyncResult>> registerEvent(
      CalendarEventDraft draft) async {
    final repo = _ref.read(calendarRepositoryProvider);
    return repo.createEvent(draft);
  }
}

final calendarSyncControllerProvider =
    Provider<CalendarSyncController>((ref) {
  return CalendarSyncController(ref);
});
