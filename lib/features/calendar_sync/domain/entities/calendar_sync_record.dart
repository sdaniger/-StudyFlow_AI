import 'package:equatable/equatable.dart';

class CalendarSyncRecord extends Equatable {
  final String id;
  final String localEntityId;
  final String localEntityType;
  final String? googleEventId;
  final String syncStatus;
  final DateTime? lastSyncedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CalendarSyncRecord({
    required this.id,
    required this.localEntityId,
    required this.localEntityType,
    this.googleEventId,
    this.syncStatus = 'pending',
    this.lastSyncedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id, localEntityId, localEntityType, googleEventId,
        syncStatus, lastSyncedAt, createdAt, updatedAt,
      ];
}
