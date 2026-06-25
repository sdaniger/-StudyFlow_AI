import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyflow_ai/gen_l10n/app_localizations.dart';
import '../../application/providers/small_step_providers.dart';
import '../widgets/small_step_tile.dart';

class SmallStepsScreen extends ConsumerStatefulWidget {
  final String taskId;
  final String taskTitle;
  final String? taskSubject;

  const SmallStepsScreen({
    super.key,
    required this.taskId,
    required this.taskTitle,
    this.taskSubject,
  });

  @override
  ConsumerState<SmallStepsScreen> createState() => _SmallStepsScreenState();
}

class _SmallStepsScreenState extends ConsumerState<SmallStepsScreen> {
  final _controller = TextEditingController();
  bool _isAiBreakingDown = false;

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

  Future<void> _aiBreakdown() async {
    setState(() => _isAiBreakingDown = true);
    await ref
        .read(smallStepControllerProvider(widget.taskId).notifier)
        .aiBreakdown(widget.taskTitle, widget.taskSubject);
    if (mounted) {
      setState(() => _isAiBreakingDown = false);
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.smallStepsAdded)),
      );
    }
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
        actions: [
          if (totalCount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SizedBox(
                  width: 32,
                  height: 20,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 20,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      Center(
                        child: Text(
                          '$completedCount/$totalCount',
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          IconButton(
            icon: _isAiBreakingDown
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.auto_awesome),
            tooltip: l10n.smallStepsAiBreakdown,
            onPressed: _isAiBreakingDown ? null : _aiBreakdown,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                final allSteps = [...incomplete, ...complete];

                return ReorderableListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: allSteps.length,
                  onReorder: (oldIndex, newIndex) {
                    ref
                        .read(smallStepControllerProvider(widget.taskId).notifier)
                        .reorderSteps(oldIndex, newIndex);
                  },
                  proxyDecorator: (child, index, animation) {
                    return Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: child,
                    );
                  },
                  itemBuilder: (context, index) {
                    return SmallStepTile(
                      key: ValueKey(allSteps[index].id),
                      step: allSteps[index],
                      index: index,
                      onToggle: () => ref
                          .read(smallStepControllerProvider(widget.taskId).notifier)
                          .toggleStep(allSteps[index].id),
                      onDelete: () => ref
                          .read(smallStepControllerProvider(widget.taskId).notifier)
                          .deleteStep(allSteps[index].id),
                      onUpdate: (newTitle) => ref
                          .read(smallStepControllerProvider(widget.taskId).notifier)
                          .updateStep(allSteps[index].id, newTitle),
                      onNotesUpdate: (notes) => ref
                          .read(smallStepControllerProvider(widget.taskId).notifier)
                          .updateStepNotes(allSteps[index].id, notes),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
