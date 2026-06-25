import 'package:uuid/uuid.dart';
import '../../domain/entities/app_backup_data.dart';
import '../../domain/entities/drive_backup_result.dart';
import '../../domain/entities/drive_sync_status.dart';
import '../../domain/repositories/drive_sync_repository.dart';
import '../../../../core/result/app_result.dart';

class MockDriveSyncRepository implements DriveSyncRepository {
  static const _uuid = Uuid();

  AppBackupData? _storedData;

  @override
  Future<AppResult<DriveBackupResult>> backupAppData(
      AppBackupData data) async {
    await Future.delayed(const Duration(seconds: 1));
    _storedData = data;
    return AppSuccess(
      DriveBackupResult(
        success: true,
        backupId: _uuid.v4(),
        backedUpAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<AppResult<AppBackupData?>> restoreAppData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (_storedData != null) {
      return AppSuccess(_storedData);
    }
    return const AppSuccess(null);
  }

  @override
  Future<AppResult<DriveSyncStatus>> getSyncStatus() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return AppSuccess(
      DriveSyncStatus(
        isConnected: true,
        lastBackupAt: _storedData?.exportedAt,
        pendingChanges: _storedData == null ? 0 : 0,
        statusMessage: 'Ready',
      ),
    );
  }
}
