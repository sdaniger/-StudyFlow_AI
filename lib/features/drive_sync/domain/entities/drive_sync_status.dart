import 'package:equatable/equatable.dart';

class DriveSyncStatus extends Equatable {
  final bool isConnected;
  final DateTime? lastBackupAt;
  final DateTime? lastRestoreAt;
  final int pendingChanges;
  final String? statusMessage;

  const DriveSyncStatus({
    this.isConnected = false,
    this.lastBackupAt,
    this.lastRestoreAt,
    this.pendingChanges = 0,
    this.statusMessage = 'Ready',
  });

  @override
  List<Object?> get props => [
        isConnected, lastBackupAt, lastRestoreAt,
        pendingChanges, statusMessage,
      ];
}
