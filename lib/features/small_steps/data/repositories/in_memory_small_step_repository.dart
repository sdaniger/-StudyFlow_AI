import '../../domain/entities/small_step.dart';
import '../../domain/repositories/small_step_repository.dart';
import '../../../../core/result/app_result.dart';
import '../../../../core/errors/app_error.dart';

class InMemorySmallStepRepository implements SmallStepRepository {
  final _steps = <String, SmallStep>{};

  InMemorySmallStepRepository({List<SmallStep>? initialData}) {
    if (initialData != null) {
      for (final step in initialData) {
        _steps[step.id] = step;
      }
    }
  }

  @override
  Future<AppResult<List<SmallStep>>> getStepsForTask(String taskId) async {
    final result = _steps.values
        .where((s) => s.taskId == taskId)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    return AppSuccess(result);
  }

  @override
  Future<AppResult<Map<String, List<SmallStep>>>> getStepsForTasks(List<String> taskIds) async {
    final result = <String, List<SmallStep>>{};
    for (final id in taskIds) {
      result[id] = _steps.values
          .where((s) => s.taskId == id)
          .toList()
        ..sort((a, b) => a.order.compareTo(b.order));
    }
    return AppSuccess(result);
  }

  @override
  Future<AppResult<SmallStep>> createStep(SmallStep step) async {
    _steps[step.id] = step;
    return AppSuccess(step);
  }

  @override
  Future<AppResult<SmallStep>> updateStep(SmallStep step) async {
    if (!_steps.containsKey(step.id)) {
      return AppFailure(DatabaseError('Step not found'));
    }
    _steps[step.id] = step;
    return AppSuccess(step);
  }

  @override
  Future<AppResult<void>> deleteStep(String stepId) async {
    if (!_steps.containsKey(stepId)) {
      return AppFailure(DatabaseError('Step not found'));
    }
    _steps.remove(stepId);
    return const AppSuccess(null);
  }

  @override
  Future<AppResult<SmallStep>> toggleStep(String stepId) async {
    final step = _steps[stepId];
    if (step == null) {
      return AppFailure(DatabaseError('Step not found'));
    }
    final updated = step.copyWith(
      isCompleted: !step.isCompleted,
      updatedAt: DateTime.now(),
    );
    _steps[stepId] = updated;
    return AppSuccess(updated);
  }

  @override
  Future<AppResult<List<SmallStep>>> reorderSteps(
      String taskId, List<String> stepIds) async {
    final steps = <SmallStep>[];
    for (var i = 0; i < stepIds.length; i++) {
      final step = _steps[stepIds[i]];
      if (step != null && step.taskId == taskId) {
        final reordered = step.copyWith(order: i, updatedAt: DateTime.now());
        _steps[step.id] = reordered;
        steps.add(reordered);
      }
    }
    steps.sort((a, b) => a.order.compareTo(b.order));
    return AppSuccess(steps);
  }
}
