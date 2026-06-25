import 'package:flutter/material.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'glass_card.dart';

class DriveSyncStatusCard extends StatelessWidget {
  final String status;
  final String? lastSynced;
  final bool isSyncing;
  final bool isConnected;
  final VoidCallback? onBackup;
  final VoidCallback? onRestore;

  const DriveSyncStatusCard({
    super.key,
    required this.status,
    this.lastSynced,
    this.isSyncing = false,
    this.isConnected = false,
    this.onBackup,
    this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: _statusColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isSyncing
                      ? Icons.sync
                      : isConnected
                          ? Icons.cloud_done
                          : Icons.cloud_off,
                  color: _statusColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.driveSyncCardTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      status,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: _statusColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (lastSynced != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${AppLocalizations.of(context)!.driveSyncLastSynced}$lastSynced',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          if (isSyncing) ...[
            const SizedBox(height: AppSpacing.md),
            const LinearProgressIndicator(
              backgroundColor: AppColors.primary,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: isSyncing ? null : onBackup,
                  icon: const Icon(Icons.cloud_upload, size: 18),
                  label: Text(AppLocalizations.of(context)!.driveSyncButtonBackup),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isSyncing ? null : onRestore,
                  icon: const Icon(Icons.cloud_download, size: 18),
                  label: Text(AppLocalizations.of(context)!.driveSyncButtonRestore),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color get _statusColor {
    if (isSyncing) return AppColors.info;
    if (status.contains('Error')) return AppColors.error;
    if (status.contains('Ready')) return AppColors.success;
    return AppColors.textSecondaryLight;
  }
}
