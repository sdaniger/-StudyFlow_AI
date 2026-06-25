import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/drive_sync_controller.dart';
import '../../domain/entities/drive_sync_status.dart';
import '../../domain/entities/drive_backup_result.dart';
import '../../domain/entities/app_backup_data.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/result/app_result.dart';
import '../../../../shared/widgets/glass_container.dart';

import '../../../../shared/widgets/drive_sync_status_card.dart';

class DriveSyncScreen extends ConsumerWidget {
  const DriveSyncScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(driveSyncStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drive Sync'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            statusAsync.when(
              data: (result) {
                if (result is AppSuccess<DriveSyncStatus>) {
                  final status = result.data;
                  return DriveSyncStatusCard(
                    status: status.statusMessage ?? 'Ready',
                    lastSynced: status.lastBackupAt?.toString(),
                    onBackup: () => _handleBackup(context, ref),
                    onRestore: () => _handleRestore(context, ref),
                  );
                }
                return const SizedBox.shrink();
              },
              loading: () => const DriveSyncStatusCard(
                status: 'Checking...',
                isSyncing: true,
              ),
              error: (_, __) => const DriveSyncStatusCard(
                status: 'Error',
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            GlassContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline,
                          color: AppColors.primary, size: 20),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'About Google Drive Sync',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Your data is backed up to Google Drive appDataFolder.\n'
                    'This folder is only accessible by this app and is not visible to users.\n\n'
                    'Backup includes:\n'
                    '- Tasks and study plans\n'
                    '- Habits and logs\n'
                    '- Review schedules\n'
                    '- Pomodoro sessions\n'
                    '- App settings',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleBackup(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(driveSyncControllerProvider);
    final result = await controller.backup();

    if (result is AppSuccess<DriveBackupResult>) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Backup completed successfully!')),
        );
      }
      ref.invalidate(driveSyncStatusProvider);
    } else if (result is AppFailure<DriveBackupResult>) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup failed: ${result.error.message}')),
        );
      }
    }
  }

  Future<void> _handleRestore(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restore Data?'),
        content: const Text(
          'This will replace your current data with the backup. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final controller = ref.read(driveSyncControllerProvider);
    final result = await controller.restore();

    if (result is AppSuccess<AppBackupData?>) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.data != null
                  ? 'Data restored successfully!'
                  : 'No backup found',
            ),
          ),
        );
      }
      ref.invalidate(driveSyncStatusProvider);
    } else if (result is AppFailure<AppBackupData?>) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Restore failed: ${result.error.message}')),
        );
      }
    }
  }
}
