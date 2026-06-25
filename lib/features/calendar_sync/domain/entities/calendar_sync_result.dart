import 'package:equatable/equatable.dart';

class CalendarSyncResult extends Equatable {
  final bool success;
  final String? eventId;
  final String? errorMessage;

  const CalendarSyncResult({
    required this.success,
    this.eventId,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [success, eventId, errorMessage];
}
