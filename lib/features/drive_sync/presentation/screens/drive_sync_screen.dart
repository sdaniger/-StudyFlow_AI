import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
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
        title: Text(AppLocalizations.of(context)!.driveAppBarTitle),
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
                    status: status.statusMessage ?? AppLocalizations.of(context)!.driveStatusReady,
                    lastSynced: status.lastBackupAt?.toString(),
                    onBackup: () => _handleBackup(context, ref),
                    onRestore: () => _handleRestore(context, ref),
                  );
                }
                return const SizedBox.shrink();
              },
              loading: () => DriveSyncStatusCard(
                status: AppLocalizations.of(context)!.driveStatusChecking,
                isSyncing: true,
              ),
              error: (_, __) => DriveSyncStatusCard(
                status: AppLocalizations.of(context)!.driveStatusError,
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
                        AppLocalizations.of(context)!.driveSectionAbout,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    AppLocalizations.of(context)!.driveDescription,
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
          SnackBar(content: Text(AppLocalizations.of(context)!.driveBackupSuccess)),
        );
      }
      ref.invalidate(driveSyncStatusProvider);
    } else if (result is AppFailure<DriveBackupResult>) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.tasksError}${result.error.message}')),
        );
      }
    }
  }

  Future<void> _handleRestore(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.driveRestoreTitle),
        content: Text(
          AppLocalizations.of(context)!.driveRestoreMessage,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(AppLocalizations.of(context)!.driveButtonCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(AppLocalizations.of(context)!.driveButtonRestore),
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
                  ? AppLocalizations.of(context)!.driveRestoreSuccess
                  : AppLocalizations.of(context)!.driveNoBackup,
            ),
          ),
        );
      }
      ref.invalidate(driveSyncStatusProvider);
    } else if (result is AppFailure<AppBackupData?>) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.tasksError}${result.error.message}')),
        );
      }
    }
  }
}
