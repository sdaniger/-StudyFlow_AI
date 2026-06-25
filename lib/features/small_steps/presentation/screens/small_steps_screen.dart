import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../application/providers/small_step_providers.dart';
import '../widgets/small_step_tile.dart';

class SmallStepsScreen extends ConsumerStatefulWidget {
  final String taskId;
  final String taskTitle;

  const SmallStepsScreen({
    super.key,
    required this.taskId,
    required this.taskTitle,
  });

  @override
  ConsumerState<SmallStepsScreen> createState() => _SmallStepsScreenState();
}

class _SmallStepsScreenState extends ConsumerState<SmallStepsScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addStep() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    ref.read(smallStepControllerProvider(widget.taskId).notifier).addStep(title);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final stepsState = ref.watch(smallStepControllerProvider(widget.taskId));
    final completedCount = stepsState.maybeWhen(
      data: (steps) => steps.where((s) => s.isCompleted).length,
      orElse: () => 0,
    );
    final totalCount = stepsState.maybeWhen(
      data: (steps) => steps.length,
      orElse: () => 0,
    );
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskTitle),
      ),
      body: Column(
        children: [
          if (totalCount > 0)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${l10n.smallStepsProgress} $completedCount/$totalCount',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: l10n.smallStepsHint,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onSubmitted: (_) => _addStep(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _addStep,
                  child: Text(l10n.smallStepsAdd),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: stepsState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (steps) {
                if (steps.isEmpty) {
                  return Center(
                    child: Text(
                      l10n.smallStepsEmpty,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                final incomplete = steps.where((s) => !s.isCompleted).toList();
                final complete = steps.where((s) => s.isCompleted).toList();

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    ...incomplete.map((step) => SmallStepTile(
                      step: step,
                      onToggle: () => ref
                          .read(smallStepControllerProvider(widget.taskId).notifier)
                          .toggleStep(step.id),
                      onDelete: () => ref
                          .read(smallStepControllerProvider(widget.taskId).notifier)
                          .deleteStep(step.id),
                    )),
                    if (complete.isNotEmpty) ...[
                      const Divider(height: 32),
                      ...complete.map((step) => SmallStepTile(
                        step: step,
                        onToggle: () => ref
                            .read(smallStepControllerProvider(widget.taskId).notifier)
                            .toggleStep(step.id),
                        onDelete: () => ref
                            .read(smallStepControllerProvider(widget.taskId).notifier)
                            .deleteStep(step.id),
                      )),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
