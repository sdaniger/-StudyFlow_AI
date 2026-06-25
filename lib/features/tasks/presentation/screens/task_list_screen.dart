import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../application/providers/task_providers.dart';
import '../controllers/task_controller.dart';
import '../../domain/entities/task_status.dart';
import '../../domain/entities/task.dart';
import '../../../../core/result/app_result.dart';
import '../../../../shared/widgets/task_tile.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tasksAppBarTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: tasksAsync.when(
        data: (result) {
          if (result is AppSuccess<List<Task>>) {
            final tasks = result.data;
            if (tasks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.task_alt,
                        size: 64, color: AppColors.primary.withAlpha(128)),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      AppLocalizations.of(context)!.tasksEmptyTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      AppLocalizations.of(context)!.tasksEmptySubtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskTile(
                  title: task.title,
                  subject: task.subject,
                  priority: task.priority.label,
                  isCompleted: task.status == TaskStatus.done,
                  onTap: () => context.push('/tasks/${task.id}/edit'),
                  onToggleComplete: () {
                    ref.read(taskControllerProvider).completeTask(task);
                  },
                );
              },
            );
          }
          if (result is AppFailure<List<Task>>) {
            return Center(
              child: Text('${AppLocalizations.of(context)!.tasksError}${result.error.message}'),
            );
          }
          return Center(child: Text(AppLocalizations.of(context)!.tasksUnexpectedState));
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text('${AppLocalizations.of(context)!.tasksError}$error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/tasks/new'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
