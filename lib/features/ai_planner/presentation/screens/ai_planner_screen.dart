import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        title: const Text('AI Study Planner'),
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
                    'AI Study Plan Generator',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Describe your study goal and AI will create a personalized plan.',
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
              Text('Study Goal', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _goalController,
                decoration: const InputDecoration(
                  hintText: 'e.g., Pass JLPT N3 in 3 months',
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
              Text('Subject', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              DropdownButtonFormField<String>(
                value: _selectedSubject,
                decoration: const InputDecoration(hintText: 'Select subject'),
                items: ['English', 'Mathematics', 'Physics', 'Other']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
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
              Text('Daily Study Time',
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
                      label: '$_dailyMinutes min',
                      onChanged: (v) =>
                          setState(() => _dailyMinutes = v.round()),
                    ),
                  ),
                  Text('$_dailyMinutes min'),
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
              Text('Difficulty',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: ['Beginner', 'Intermediate', 'Advanced']
                    .map((level) => Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.sm),
                          child: ChoiceChip(
                            label: Text(level),
                            selected: _selectedDifficulty == level,
                            onSelected: (_) =>
                                setState(() => _selectedDifficulty = level),
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
              Text('Concerns / Notes',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _concernsController,
                decoration: const InputDecoration(
                  hintText: 'Any specific areas you want to focus on?',
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        PrimaryActionButton(
          label: _isLoading ? 'Generating...' : 'Generate Study Plan',
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
                    'Study Plan Generated',
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
        SectionHeader(title: "Today's Tasks"),
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
        SectionHeader(title: 'This Week'),
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
                label: 'Add to Tasks',
                icon: Icons.add,
                onPressed: () {
                  final controller = ref.read(aiPlannerControllerProvider);
                  controller.addGeneratedTasks(
                    _plan!.todayTasks.map((t) => {'title': t}).toList(),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tasks added!')),
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
            child: const Text('Generate Again'),
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
          SnackBar(content: Text('Error: ${result.error.message}')),
        );
      }
    }
  }
}
