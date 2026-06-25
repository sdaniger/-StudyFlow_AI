import 'package:flutter/material.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class PomodoroTimerCircle extends StatefulWidget {
  final int secondsRemaining;
  final int totalSeconds;
  final bool isRunning;
  final String mode;
  final VoidCallback? onToggle;
  final VoidCallback? onReset;

  const PomodoroTimerCircle({
    super.key,
    required this.secondsRemaining,
    required this.totalSeconds,
    required this.isRunning,
    required this.mode,
    this.onToggle,
    this.onReset,
  });

  @override
  State<PomodoroTimerCircle> createState() => _PomodoroTimerCircleState();
}

class _PomodoroTimerCircleState extends State<PomodoroTimerCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    if (widget.isRunning) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(PomodoroTimerCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRunning && !oldWidget.isRunning) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isRunning && oldWidget.isRunning) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.totalSeconds > 0
        ? widget.secondsRemaining / widget.totalSeconds
        : 1.0;
    final minutes = widget.secondsRemaining ~/ 60;
    final seconds = widget.secondsRemaining % 60;
    final timeText = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final scale = 1.0 + (_pulseController.value * 0.02);
        return GestureDetector(
          onTap: widget.onToggle,
          child: Transform.scale(
            scale: widget.isRunning ? scale : 1.0,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.glassDark
                    : AppColors.glassLight,
                border: Border.all(
                  color: AppColors.primary.withAlpha(77),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(26),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 6,
                      backgroundColor: AppColors.primary.withAlpha(26),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _modeLabel,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        timeText,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w300,
                                ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              widget.isRunning
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              color: AppColors.primary,
                              size: 40,
                            ),
                            onPressed: widget.onToggle,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          IconButton(
                            icon: const Icon(
                              Icons.restart_alt,
                              color: AppColors.textSecondaryLight,
                              size: 28,
                            ),
                            onPressed: widget.onReset,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String get _modeLabel {
    switch (widget.mode) {
      case 'focus':
        return AppLocalizations.of(context)!.pomodoroLabelFocus;
      case 'shortBreak':
        return AppLocalizations.of(context)!.pomodoroLabelShortBreak;
      case 'longBreak':
        return AppLocalizations.of(context)!.pomodoroLabelLongBreak;
      default:
        return AppLocalizations.of(context)!.pomodoroLabelFocus;
    }
  }
}
