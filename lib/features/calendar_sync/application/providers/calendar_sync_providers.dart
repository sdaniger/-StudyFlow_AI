import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_calendar_repository.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../../../../core/config/app_config.dart';

final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  if (AppConfig.useMocks) {
    return MockCalendarRepository();
  }
  return MockCalendarRepository();
});
