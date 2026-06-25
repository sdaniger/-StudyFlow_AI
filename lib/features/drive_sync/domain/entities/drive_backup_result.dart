import 'package:equatable/equatable.dart';

class DriveBackupResult extends Equatable {
  final bool success;
  final String? backupId;
  final String? errorMessage;
  final DateTime? backedUpAt;

  const DriveBackupResult({
    required this.success,
    this.backupId,
    this.errorMessage,
    this.backedUpAt,
  });

  @override
  List<Object?> get props => [success, backupId, errorMessage, backedUpAt];
}
