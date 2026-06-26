import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/providers/shared_providers.dart';
import '../../application/providers/settings_providers.dart';
import '../widgets/api_key_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsAppBarTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: l10n.settingsSectionAppearance),
            GlassContainer(
              child: SwitchListTile(
                title: Text(l10n.settingsDarkMode),
                subtitle: Text(l10n.settingsDarkModeSubtitle),
                value: isDarkMode,
                onChanged: (value) {
                  ref.read(themeModeProvider.notifier).state = value;
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: l10n.settingsSectionAi),
            GlassContainer(
              child: Column(
                children: [
                  ApiKeyTile(
                    label: l10n.settingsApiKeyGemini,
                    icon: Icons.auto_awesome,
                    initialValue: ref.read(apiKeyConfigProvider).geminiApiKey,
                    onSaved: (key) => ref.read(apiKeyConfigProvider.notifier).setGeminiKey(key),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ApiKeyTile(
                    label: l10n.settingsApiKeyOpenRouter,
                    icon: Icons.swap_horiz,
                    initialValue: ref.read(apiKeyConfigProvider).openRouterApiKey,
                    onSaved: (key) => ref.read(apiKeyConfigProvider.notifier).setOpenRouterKey(key),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: l10n.settingsSectionData),
            GlassContainer(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.cloud_upload, color: AppColors.primary),
                    title: Text(l10n.settingsBackupDrive),
                    subtitle: Text(l10n.settingsBackupDriveSubtitle),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.cloud_download, color: AppColors.primary),
                    title: Text(l10n.settingsRestoreDrive),
                    subtitle: Text(l10n.settingsRestoreDriveSubtitle),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: l10n.settingsSectionAIPrivacy),
            GlassContainer(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.settingsDataSentToAI, style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: AppSpacing.sm),
                    Text(l10n.settingsAIPrivacyDescription, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: l10n.settingsSectionAbout),
            GlassContainer(
              child: Column(
                children: [
                  ListTile(
                    title: Text(l10n.settingsVersion),
                    subtitle: Text(l10n.appVersion),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: Text(l10n.settingsAppName),
                    subtitle: Text(l10n.settingsAppDescription),
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
