import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/repositories/in_memory_small_step_repository.dart';
import '../../domain/entities/small_step.dart';
import '../../domain/repositories/small_step_repository.dart';
import '../../domain/usecases/get_steps_for_task.dart';
import '../../domain/usecases/create_small_step.dart';
import '../../domain/usecases/toggle_small_step.dart';
import '../../domain/usecases/delete_small_step.dart';
import '../../domain/usecases/reorder_small_steps.dart';
import '../../domain/usecases/ai_breakdown_steps.dart';
import '../../../../core/result/app_result.dart';
import '../../../ai_planner/application/providers/ai_planner_providers.dart';

final smallStepRepositoryProvider = Provider<SmallStepRepository>((ref) {
  return InMemorySmallStepRepository();
});

final getStepsForTaskProvider = Provider<GetStepsForTask>((ref) {
  return GetStepsForTask(ref.watch(smallStepRepositoryProvider));
});

final createSmallStepProvider = Provider<CreateSmallStep>((ref) {
  return CreateSmallStep(ref.watch(smallStepRepositoryProvider));
});

final toggleSmallStepProvider = Provider<ToggleSmallStep>((ref) {
  return ToggleSmallStep(ref.watch(smallStepRepositoryProvider));
});

final deleteSmallStepProvider = Provider<DeleteSmallStep>((ref) {
  return DeleteSmallStep(ref.watch(smallStepRepositoryProvider));
});

final reorderStepsProvider = Provider<ReorderSmallSteps>((ref) {
  return ReorderSmallSteps(ref.watch(smallStepRepositoryProvider));
});

final aiBreakdownStepsProvider = Provider<AiBreakdownSteps>((ref) {
  return AiBreakdownSteps(
    ref.watch(smallStepRepositoryProvider),
    ref.watch(aiPlannerRepositoryProvider),
  );
});

final stepsForTaskProvider = FutureProvider.autoDispose.family<List<SmallStep>, String>((ref, taskId) async {
  final useCase = ref.watch(getStepsForTaskProvider);
  final result = await useCase(taskId);
  if (result is AppSuccess<List<SmallStep>>) {
    return result.data;
  }
  return [];
});

final stepsForTasksProvider = FutureProvider.autoDispose.family<Map<String, List<SmallStep>>, List<String>>((ref, taskIds) async {
  final repo = ref.watch(smallStepRepositoryProvider);
  final result = await repo.getStepsForTasks(taskIds);
  if (result is AppSuccess<Map<String, List<SmallStep>>>) {
    return result.data;
  }
  return {};
});

final smallStepControllerProvider = StateNotifierProvider.family<SmallStepController, AsyncValue<List<SmallStep>>, String>((ref, taskId) {
  return SmallStepController(ref, taskId);
});

class SmallStepController extends StateNotifier<AsyncValue<List<SmallStep>>> {
  final Ref _ref;
  final String taskId;

  SmallStepController(this._ref, this.taskId) : super(const AsyncValue.loading()) {
    _loadSteps();
  }

  Future<void> _loadSteps() async {
    final useCase = _ref.read(getStepsForTaskProvider);
    final result = await useCase(taskId);
    if (result is AppSuccess<List<SmallStep>>) {
      state = AsyncValue.data(result.data);
    } else if (result is AppFailure<List<SmallStep>>) {
      state = AsyncValue.error(result.error, StackTrace.current);
    }
  }

  Future<void> addStep(String title) async {
    final create = _ref.read(createSmallStepProvider);
    final steps = state.maybeWhen(data: (d) => d, orElse: () => <SmallStep>[]);
    final step = SmallStep(
      id: const Uuid().v4(),
      taskId: taskId,
      title: title,
      order: steps.length,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final result = await create(step);
    if (result is AppSuccess) _loadSteps();
  }

  Future<void> toggleStep(String stepId) async {
    final toggle = _ref.read(toggleSmallStepProvider);
    final result = await toggle(stepId);
    if (result is AppSuccess) _loadSteps();
  }

  Future<void> deleteStep(String stepId) async {
    final delete = _ref.read(deleteSmallStepProvider);
    final result = await delete(stepId);
    if (result is AppSuccess) _loadSteps();
  }

  Future<void> updateStep(String stepId, String newTitle) async {
    final repo = _ref.read(smallStepRepositoryProvider);
    final current = state.maybeWhen(data: (d) => d.firstWhere((s) => s.id == stepId), orElse: () => null);
    if (current == null) return;
    final updated = current.copyWith(title: newTitle, updatedAt: DateTime.now());
    final result = await repo.updateStep(updated);
    if (result is AppSuccess) _loadSteps();
  }

  Future<void> reorderSteps(int oldIndex, int newIndex) async {
    final steps = state.maybeWhen(data: (d) => List<SmallStep>.from(d), orElse: () => <SmallStep>[]);
    if (steps.isEmpty) return;
    final item = steps.removeAt(oldIndex);
    steps.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, item);
    final ids = steps.map((s) => s.id).toList();
    final reorder = _ref.read(reorderStepsProvider);
    final result = await reorder(taskId, ids);
    if (result is AppSuccess) _loadSteps();
  }

  Future<void> updateStepNotes(String stepId, String notes) async {
    final repo = _ref.read(smallStepRepositoryProvider);
    final current = state.maybeWhen(
      data: (d) => d.firstWhere((s) => s.id == stepId),
      orElse: () => null,
    );
    if (current == null) return;
    final updated = current.copyWith(notes: notes, updatedAt: DateTime.now());
    final result = await repo.updateStep(updated);
    if (result is AppSuccess) _loadSteps();
  }

  Future<void> aiBreakdown(String taskTitle, String? subject) async {
    final useCase = _ref.read(aiBreakdownStepsProvider);
    state = const AsyncValue.loading();
    final result = await useCase(taskId, taskTitle, subject);
    if (result is AppSuccess) {
      _loadSteps();
    } else if (result is AppFailure<List<SmallStep>>) {
      state = AsyncValue.error(result.error, StackTrace.current);
    }
  }
}
