import '../../../../core/result/app_result.dart';
import '../entities/app_backup_data.dart';
import '../entities/drive_backup_result.dart';
import '../entities/drive_sync_status.dart';

abstract class DriveSyncRepository {
  Future<AppResult<DriveBackupResult>> backupAppData(AppBackupData data);
  Future<AppResult<AppBackupData?>> restoreAppData();
  Future<AppResult<DriveSyncStatus>> getSyncStatus();
}
