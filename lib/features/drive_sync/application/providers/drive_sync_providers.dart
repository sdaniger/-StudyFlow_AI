import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_drive_sync_repository.dart';
import '../../data/repositories/real_drive_sync_repository.dart';
import '../../domain/repositories/drive_sync_repository.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/security/secure_config.dart';

final driveSyncRepositoryProvider = Provider<DriveSyncRepository>((ref) {
  if (AppConfig.useMocks || SecureConfig.googleClientId == null) {
    return MockDriveSyncRepository();
  }
  return RealDriveSyncRepository();
});
