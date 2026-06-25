import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Appearance'),
            GlassContainer(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Toggle dark theme'),
                    value: isDarkMode,
                    onChanged: (value) {
                      ref.read(themeModeProvider.notifier).state = value;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: 'Data'),
            GlassContainer(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.cloud_upload,
                        color: AppColors.primary),
                    title: const Text('Backup to Drive'),
                    subtitle: const Text('Manual backup'),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.cloud_download,
                        color: AppColors.primary),
                    title: const Text('Restore from Drive'),
                    subtitle: const Text('Manual restore'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: 'AI Privacy'),
            GlassContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data sent to AI',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'When using AI features, the following data is sent:\n'
                          '- Your study goals and preferences\n'
                          '- Task titles and subjects\n'
                          '- Difficulty levels\n\n'
                          'No personal identifiable information is shared.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: 'About'),
            GlassContainer(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Version'),
                    subtitle: const Text('1.0.0'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('StudyFlow AI'),
                    subtitle: const Text('AI-powered study assistant'),
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
