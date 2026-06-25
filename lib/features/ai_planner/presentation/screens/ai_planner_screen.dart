import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../controllers/ai_planner_controller.dart';
import '../../domain/entities/study_plan.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/result/app_result.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/primary_action_button.dart';
import '../../../../shared/widgets/section_header.dart';

class AiPlannerScreen extends ConsumerStatefulWidget {
  const AiPlannerScreen({super.key});

  @override
  ConsumerState<AiPlannerScreen> createState() => _AiPlannerScreenState();
}

class _AiPlannerScreenState extends ConsumerState<AiPlannerScreen> {
  final _goalController = TextEditingController();
  final _concernsController = TextEditingController();
  String? _selectedSubject;
  String? _selectedDifficulty;
  int _dailyMinutes = 120;
  bool _isLoading = false;
  StudyPlan? _plan;

  Map<String, String> get _subjectEntries => {
        'English': AppLocalizations.of(context)!.subjectEnglish,
        'Mathematics': AppLocalizations.of(context)!.subjectMathematics,
        'Physics': AppLocalizations.of(context)!.subjectPhysics,
        'Other': AppLocalizations.of(context)!.subjectOther,
      };

  Map<String, String> get _difficultyEntries => {
        'Beginner': AppLocalizations.of(context)!.aiPlannerDifficultyBeginner,
        'Intermediate': AppLocalizations.of(context)!.aiPlannerDifficultyIntermediate,
        'Advanced': AppLocalizations.of(context)!.aiPlannerDifficultyAdvanced,
      };

  @override
  void dispose() {
    _goalController.dispose();
    _concernsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aiPlannerAppBarTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: _plan == null ? _buildInputForm() : _buildPlanPreview(),
      ),
    );
  }

  Widget _buildInputForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withAlpha(26),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: AppColors.accent,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    AppLocalizations.of(context)!.aiPlannerCardTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                AppLocalizations.of(context)!.aiPlannerCardDescription,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.aiPlannerFieldGoal, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _goalController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.aiPlannerHintGoal,
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.aiPlannerFieldSubject, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              DropdownButtonFormField<String>(
                value: _selectedSubject,
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.aiPlannerHintSubject),
                items: _subjectEntries.entries
                    .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedSubject = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.aiPlannerFieldDailyTime,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  const Icon(Icons.timer, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Slider(
                      value: _dailyMinutes.toDouble(),
                      min: 15,
                      max: 480,
                      divisions: 31,
                      label: '$_dailyMinutes ${AppLocalizations.of(context)!.aiPlannerMinLabel}',
                      onChanged: (v) =>
                          setState(() => _dailyMinutes = v.round()),
                    ),
                  ),
                  Text('$_dailyMinutes ${AppLocalizations.of(context)!.aiPlannerMinLabel}'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.aiPlannerFieldDifficulty,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: _difficultyEntries.entries
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.sm),
                          child: ChoiceChip(
                            label: Text(e.value),
                            selected: _selectedDifficulty == e.key,
                            onSelected: (_) =>
                                setState(() => _selectedDifficulty = e.key),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.aiPlannerFieldNotes,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _concernsController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.aiPlannerHintNotes,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        PrimaryActionButton(
          label: _isLoading ? AppLocalizations.of(context)!.aiPlannerButtonGenerating : AppLocalizations.of(context)!.aiPlannerButtonGenerate,
          icon: Icons.auto_awesome,
          isLoading: _isLoading,
          onPressed: _isLoading ? null : _handleGenerate,
        ),
      ],
    );
  }

  Widget _buildPlanPreview() {
    if (_plan == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: AppColors.success, size: 24),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    AppLocalizations.of(context)!.aiPlannerSuccessTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.success,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                _plan!.goal,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.accent.withAlpha(26),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb, color: AppColors.accent),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        _plan!.advice,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SectionHeader(title: AppLocalizations.of(context)!.aiPlannerSectionToday),
        ...(_plan!.todayTasks.map((t) => GlassContainer(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline,
                      color: AppColors.primary.withAlpha(128), size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text(t)),
                ],
              ),
            ))),
        const SizedBox(height: AppSpacing.md),
        SectionHeader(title: AppLocalizations.of(context)!.aiPlannerSectionWeek),
        ...(_plan!.weeklyTasks.map((t) => GlassContainer(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  Icon(Icons.calendar_today,
                      color: AppColors.secondary.withAlpha(200), size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text(t)),
                ],
              ),
            ))),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Expanded(
              child: PrimaryActionButton(
                label: AppLocalizations.of(context)!.aiPlannerButtonAddTasks,
                icon: Icons.add,
                onPressed: () {
                  final controller = ref.read(aiPlannerControllerProvider);
                  controller.addGeneratedTasks(
                    _plan!.todayTasks.map((t) => {'title': t}).toList(),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.aiPlannerTasksAdded)),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: TextButton(
            onPressed: () => setState(() => _plan = null),
            child: Text(AppLocalizations.of(context)!.aiPlannerButtonGenerateAgain),
          ),
        ),
      ],
    );
  }

  Future<void> _handleGenerate() async {
    final goal = _goalController.text.trim();
    if (goal.isEmpty) return;

    setState(() => _isLoading = true);

    final controller = ref.read(aiPlannerControllerProvider);
    final result = await controller.generatePlan(
      goal: goal,
      dailyStudyMinutes: _dailyMinutes,
      subject: _selectedSubject,
      difficulty: _selectedDifficulty,
      concerns: _concernsController.text.trim().isEmpty
          ? null
          : _concernsController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (result is AppSuccess<StudyPlan>) {
      setState(() => _plan = result.data);
    } else if (result is AppFailure<StudyPlan>) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.tasksError}${result.error.message}')),
        );
      }
    }
  }
}
