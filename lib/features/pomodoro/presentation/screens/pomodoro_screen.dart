import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../controllers/pomodoro_controller.dart';
import '../../domain/entities/pomodoro_mode.dart';
import '../../../../shared/widgets/pomodoro_timer_circle.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_colors.dart';

class PomodoroScreen extends ConsumerWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pomodoroControllerProvider);
    final controller = ref.read(pomodoroControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pomodoroAppBarTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildModeChip(context, PomodoroMode.focus, state.mode, controller),
                  const SizedBox(width: AppSpacing.sm),
                  _buildModeChip(
                      context, PomodoroMode.shortBreak, state.mode, controller),
                  const SizedBox(width: AppSpacing.sm),
                  _buildModeChip(
                      context, PomodoroMode.longBreak, state.mode, controller),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              PomodoroTimerCircle(
                secondsRemaining: state.secondsRemaining,
                totalSeconds: state.totalSeconds,
                isRunning: state.isRunning,
                mode: state.mode.name,
                onToggle: () {
                  if (state.isRunning) {
                    controller.pause();
                  } else {
                    controller.start();
                  }
                },
                onReset: () => controller.reset(),
              ),
              const SizedBox(height: AppSpacing.xl),
              GlassContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat(context, AppLocalizations.of(context)!.pomodoroStatSession, '${state.sessionCount}'),
                    _buildStat(context, AppLocalizations.of(context)!.pomodoroStatFocus, '${state.mode.defaultMinutes}m'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeChip(
    BuildContext context,
    PomodoroMode mode,
    PomodoroMode current,
    PomodoroController controller,
  ) {
    final selected = mode == current;
    return GestureDetector(
      onTap: () => controller.setMode(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withAlpha(51)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.primary.withAlpha(77),
          ),
        ),
        child: Text(
          mode.label,
          style: TextStyle(
            color: selected ? AppColors.primary : null,
            fontWeight: selected ? FontWeight.w600 : null,
          ),
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineMedium),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
