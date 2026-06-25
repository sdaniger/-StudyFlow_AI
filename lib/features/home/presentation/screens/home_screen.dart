import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/stat_card.dart';
import '../../../../shared/widgets/ai_suggestion_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/task_tile.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../tasks/application/providers/task_providers.dart';
import '../../../tasks/domain/entities/task_status.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../../core/result/app_result.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayTasksAsync = ref.watch(todayTasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyFlow AI'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsRow(context, ref, todayTasksAsync),
            const SizedBox(height: AppSpacing.md),
            AiSuggestionCard(
              suggestion:
                  '今日は英単語の復習を先に終わらせると、午後の数学に集中しやすくなります。',
            ),
            SectionHeader(
              title: "Today's Tasks",
              trailing: TextButton(
                onPressed: () => context.push('/tasks'),
                child: const Text('View All'),
              ),
            ),
            _buildTodayTasks(context, todayTasksAsync),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<AppResult<List<Task>>> todayTasksAsync,
  ) {
    int total = 0;
    int completed = 0;

    todayTasksAsync.whenData((result) {
      if (result is AppSuccess<List<Task>>) {
        total = result.data.length;
        completed = result.data.where((t) => t.status == TaskStatus.done).length;
      }
    });

    return Row(
      children: [
        Expanded(
          child: StatCard(
            label: 'Today\'s Tasks',
            value: '$total',
            icon: Icons.task_alt,
            iconColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: StatCard(
            label: 'Completed',
            value: '$completed',
            icon: Icons.check_circle,
            iconColor: AppColors.success,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: StatCard(
            label: 'Focus Time',
            value: '0m',
            icon: Icons.timer,
            iconColor: AppColors.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildTodayTasks(
    BuildContext context,
    AsyncValue<AppResult<List<Task>>> todayTasksAsync,
  ) {
    return todayTasksAsync.when(
      data: (result) {
        if (result is AppSuccess<List<Task>>) {
          final tasks = result.data;
          if (tasks.isEmpty) {
            return GlassCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Center(
                  child: Text(
                    'No tasks for today. Add one!',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            );
          }
          return Column(
            children: tasks
                .take(5)
                .map((task) => TaskTile(
                      title: task.title,
                      subject: task.subject,
                      priority: task.priority.label,
                      isCompleted: task.status == TaskStatus.done,
                      onTap: () => context.push('/tasks/${task.id}/edit'),
                    ))
                .toList(),
          );
        }
        return const SizedBox.shrink();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
