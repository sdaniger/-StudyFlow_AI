import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'dart:convert';
import '../../domain/entities/app_backup_data.dart';
import '../../domain/entities/drive_backup_result.dart';
import '../../domain/entities/drive_sync_status.dart';
import '../../domain/repositories/drive_sync_repository.dart';
import '../../../../core/result/app_result.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/security/secure_config.dart';

class RealDriveSyncRepository implements DriveSyncRepository {
  static const _backupFileName = 'studyflow_backup.json';
  static const _scopes = [drive.DriveApi.driveAppdataScope];

  final GoogleSignIn _googleSignIn;

  RealDriveSyncRepository()
      : _googleSignIn = GoogleSignIn(
          scopes: _scopes,
          clientId: SecureConfig.googleClientId,
        );

  @override
  Future<AppResult<DriveBackupResult>> backupAppData(AppBackupData data) async {
    try {
      final account = await _googleSignIn.signInSilently();
      if (account == null) {
        return AppFailure(AuthError('Drive: not signed in. Tap Sign in first.'));
      }
      final client = await account.toAuthenticatedClient();
      final driveApi = drive.DriveApi(client);

      final jsonStr = jsonEncode(_dataToJson(data));
      final content = utf8.encode(jsonStr);
      final media = drive.Media(content, jsonStr.length);

      final existing = await _findBackupFile(driveApi);
      if (existing != null) {
        await driveApi.files.update(
          drive.File(),
          existing.id!,
          uploadMedia: media,
        );
      } else {
        await driveApi.files.create(
          drive.File(
            name: _backupFileName,
            parents: ['appDataFolder'],
          ),
          uploadMedia: media,
        );
      }

      return AppSuccess(DriveBackupResult(
        success: true,
        backupId: existing?.id,
        backedUpAt: DateTime.now(),
      ));
    } catch (e) {
      return AppFailure(DriveApiError('Backup failed: $e'));
    }
  }

  @override
  Future<AppResult<AppBackupData?>> restoreAppData() async {
    try {
      final account = await _googleSignIn.signInSilently();
      if (account == null) {
        return AppFailure(AuthError('Drive: not signed in. Tap Sign in first.'));
      }
      final client = await account.toAuthenticatedClient();
      final driveApi = drive.DriveApi(client);

      final file = await _findBackupFile(driveApi);
      if (file == null || file.id == null) return const AppSuccess(null);

      final response = await driveApi.files.get(
        file.id!,
        downloadOptions: drive.DownloadOptions.directLink,
      ) as drive.Media?;

      if (response == null) return const AppSuccess(null);

      final jsonStr = await response.stream.bytesToString();
      final json = jsonDecode(jsonStr) as Map<String, dynamic>;

      return AppSuccess(_dataFromJson(json));
    } catch (e) {
      return AppFailure(DriveApiError('Restore failed: $e'));
    }
  }

  @override
  Future<AppResult<DriveSyncStatus>> getSyncStatus() async {
    try {
      final account = await _googleSignIn.signInSilently();
      if (account == null) {
        return AppSuccess(const DriveSyncStatus(
          isConnected: false,
          statusMessage: 'Not signed in to Google Drive',
        ));
      }
      final client = await account.toAuthenticatedClient();
      final driveApi = drive.DriveApi(client);

      final files = await driveApi.files.list(
        spaces: 'appDataFolder',
        q: "name='$_backupFileName'",
        fields: 'files(id, name, createdTime, modifiedTime)',
      );

      if (files.files == null || files.files!.isEmpty) {
        return AppSuccess(DriveSyncStatus(
          isConnected: true,
          statusMessage: 'Signed in. No backup yet.',
        ));
      }

      final f = files.files!.first;
      return AppSuccess(DriveSyncStatus(
        isConnected: true,
        lastBackupAt: f.modifiedTime?.toDateTime(),
        statusMessage: 'Backup found',
      ));
    } catch (e) {
      return AppSuccess(DriveSyncStatus(
        isConnected: false,
        statusMessage: 'Drive status check failed',
      ));
    }
  }

  Future<drive.File?> _findBackupFile(drive.DriveApi api) async {
    final files = await api.files.list(
      spaces: 'appDataFolder',
      q: "name='$_backupFileName'",
      fields: 'files(id, name)',
    );
    if (files.files != null && files.files!.isNotEmpty) {
      return files.files!.first;
    }
    return null;
  }

  Map<String, dynamic> _dataToJson(AppBackupData data) => {
        'version': data.version,
        'exportedAt': data.exportedAt.toIso8601String(),
        'tasks': data.tasks,
        'habits': data.habits,
        'habitLogs': data.habitLogs,
        'reviewItems': data.reviewItems,
        'pomodoroSessions': data.pomodoroSessions,
        'settings': data.settings,
      };

  AppBackupData _dataFromJson(Map<String, dynamic> json) => AppBackupData(
        version: json['version'] as String,
        exportedAt: DateTime.parse(json['exportedAt'] as String),
        tasks: (json['tasks'] as List).cast<Map<String, dynamic>>(),
        habits: (json['habits'] as List).cast<Map<String, dynamic>>(),
        habitLogs: (json['habitLogs'] as List).cast<Map<String, dynamic>>(),
        reviewItems: (json['reviewItems'] as List).cast<Map<String, dynamic>>(),
        pomodoroSessions:
            (json['pomodoroSessions'] as List).cast<Map<String, dynamic>>(),
        settings: json['settings'] as Map<String, dynamic>?,
      );
}
