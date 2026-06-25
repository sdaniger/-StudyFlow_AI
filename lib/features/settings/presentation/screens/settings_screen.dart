import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/providers/shared_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsAppBarTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: AppLocalizations.of(context)!.settingsSectionAppearance),
            GlassContainer(
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.settingsDarkMode),
                    subtitle: Text(AppLocalizations.of(context)!.settingsDarkModeSubtitle),
                    value: isDarkMode,
                    onChanged: (value) {
                      ref.read(themeModeProvider.notifier).state = value;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: AppLocalizations.of(context)!.settingsSectionData),
            GlassContainer(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.cloud_upload,
                        color: AppColors.primary),
                    title: Text(AppLocalizations.of(context)!.settingsBackupDrive),
                    subtitle: Text(AppLocalizations.of(context)!.settingsBackupDriveSubtitle),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.cloud_download,
                        color: AppColors.primary),
                    title: Text(AppLocalizations.of(context)!.settingsRestoreDrive),
                    subtitle: Text(AppLocalizations.of(context)!.settingsRestoreDriveSubtitle),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: AppLocalizations.of(context)!.settingsSectionAIPrivacy),
            GlassContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.settingsDataSentToAI,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          AppLocalizations.of(context)!.settingsAIPrivacyDescription,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: AppLocalizations.of(context)!.settingsSectionAbout),
            GlassContainer(
              child: Column(
                children: [
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.settingsVersion),
                    subtitle: Text(AppLocalizations.of(context)!.appVersion),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.settingsAppName),
                    subtitle: Text(AppLocalizations.of(context)!.settingsAppDescription),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
