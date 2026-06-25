import 'package:uuid/uuid.dart';
import 'package:studyflow_ai/core/result/app_result.dart';
import 'package:studyflow_ai/core/errors/app_error.dart';
import '../entities/small_step.dart';
import '../repositories/small_step_repository.dart';
import '../../../ai_planner/domain/repositories/ai_planner_repository.dart';
import '../../../ai_planner/domain/entities/goal_decomposition_request.dart';
import '../../../tasks/domain/entities/task.dart';

class AiBreakdownSteps {
  final SmallStepRepository _stepRepository;
  final AiPlannerRepository _aiRepository;
  static const _uuid = Uuid();

  AiBreakdownSteps(this._stepRepository, this._aiRepository);

  Future<AppResult<List<SmallStep>>> call(
      String taskId, String taskTitle, String? subject) async {
    final request = GoalDecompositionRequest(
      goal: taskTitle,
      subject: subject ?? 'General',
    );
    final aiResult = await _aiRepository.decomposeGoal(request);
    if (aiResult is AppFailure<List<Task>>) {
      return AppFailure(aiResult.error);
    }
    if (aiResult is AppSuccess<List<Task>>) {
      final tasks = aiResult.data;
      final steps = <SmallStep>[];
      final now = DateTime.now();
      for (var i = 0; i < tasks.length; i++) {
        steps.add(SmallStep(
          id: _uuid.v4(),
          taskId: taskId,
          title: tasks[i].title,
          order: i,
          createdAt: now,
          updatedAt: now,
        ));
      }
      for (final step in steps) {
        await _stepRepository.createStep(step);
      }
      return AppSuccess(steps);
    }
    return AppFailure(UnknownError('Unexpected AI breakdown result'));
  }
}
