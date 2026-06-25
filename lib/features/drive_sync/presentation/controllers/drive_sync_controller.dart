import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/app_backup_data.dart';
import '../../domain/entities/drive_backup_result.dart';
import '../../domain/entities/drive_sync_status.dart';
import '../../application/providers/drive_sync_providers.dart';
import '../../../../core/result/app_result.dart';

class DriveSyncController {
  final Ref _ref;

  DriveSyncController(this._ref);

  Future<AppResult<DriveBackupResult>> backup() async {
    final repo = _ref.read(driveSyncRepositoryProvider);

    final backupData = AppBackupData(
      version: '1.0.0',
      exportedAt: DateTime.now(),
      tasks: [],
      habits: [],
      habitLogs: [],
      reviewItems: [],
      pomodoroSessions: [],
    );

    return repo.backupAppData(backupData);
  }

  Future<AppResult<AppBackupData?>> restore() async {
    final repo = _ref.read(driveSyncRepositoryProvider);
    return repo.restoreAppData();
  }

  Future<AppResult<DriveSyncStatus>> getStatus() async {
    final repo = _ref.read(driveSyncRepositoryProvider);
    return repo.getSyncStatus();
  }
}

final driveSyncControllerProvider = Provider<DriveSyncController>((ref) {
  return DriveSyncController(ref);
});

final driveSyncStatusProvider = FutureProvider.autoDispose((ref) async {
  final controller = ref.read(driveSyncControllerProvider);
  return controller.getStatus();
});
