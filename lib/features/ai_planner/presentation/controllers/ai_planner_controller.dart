import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/study_plan.dart';
import '../../domain/entities/study_plan_request.dart';
import '../../application/providers/ai_planner_providers.dart';
import '../../../../core/result/app_result.dart';
import '../../../tasks/presentation/controllers/task_controller.dart';

class AiPlannerController {
  final Ref _ref;

  AiPlannerController(this._ref);

  Future<AppResult<StudyPlan>> generatePlan({
    required String goal,
    DateTime? deadline,
    int dailyStudyMinutes = 120,
    String? subject,
    String? difficulty,
    String? concerns,
  }) async {
    final repo = _ref.read(aiPlannerRepositoryProvider);
    final request = StudyPlanRequest(
      goal: goal,
      deadline: deadline,
      dailyStudyMinutes: dailyStudyMinutes,
      subject: subject,
      difficulty: difficulty,
      concerns: concerns,
    );
    return repo.generateStudyPlan(request);
  }

  Future<void> addGeneratedTasks(List tasks) async {
    final taskController = _ref.read(taskControllerProvider);
    for (final task in tasks) {
      await taskController.createTask(
        title: task.title,
        subject: task.subject,
        estimatedMinutes: task.estimatedMinutes,
        createdByAi: true,
      );
    }
  }
}

final aiPlannerControllerProvider = Provider<AiPlannerController>((ref) {
  return AiPlannerController(ref);
});
