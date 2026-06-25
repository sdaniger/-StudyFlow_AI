import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_log.dart';
import '../../application/providers/habit_providers.dart';
import '../controllers/habit_controller.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/result/app_result.dart';
import '../../../../shared/widgets/habit_check_tile.dart';
import '../../../../shared/widgets/primary_action_button.dart';
import '../../../../shared/widgets/glass_container.dart';

class HabitScreen extends ConsumerStatefulWidget {
  const HabitScreen({super.key});

  @override
  ConsumerState<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends ConsumerState<HabitScreen> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habitsAsync = ref.watch(habitListProvider);
    final todayLogsAsync = ref.watch(todayHabitLogsProvider);

    final logsMap = todayLogsAsync.whenOrNull(
          data: (result) {
            if (result is AppSuccess<List<HabitLog>>) {
              return result.data.map((l) => l.habitId).toSet();
            }
            return <String>{};
          },
        ) ??
        <String>{};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: habitsAsync.when(
              data: (result) {
                if (result is AppSuccess<List<Habit>>) {
                  final habits = result.data;
                  if (habits.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.checklist,
                              size: 64,
                              color: AppColors.primary.withAlpha(128)),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'No habits yet',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Create a habit to track',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];
                      final isCompleted = logsMap.contains(habit.id);

                      return HabitCheckTile(
                        title: habit.title,
                        frequency: habit.frequency.label,
                        isCompleted: isCompleted,
                        streak: 0,
                        onToggle: () {
                          ref
                              .read(habitControllerProvider)
                              .checkHabit(habit.id);
                        },
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
          GlassContainer(
            margin: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'New habit name...',
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                PrimaryActionButton(
                  label: 'Add Habit',
                  onPressed: _handleAddHabit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleAddHabit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    ref.read(habitControllerProvider).createHabit(title: title);
    _titleController.clear();
  }
}
