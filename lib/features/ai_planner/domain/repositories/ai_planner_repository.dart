import '../../../../core/result/app_result.dart';
import '../entities/study_plan.dart';
import '../entities/study_plan_request.dart';
import '../entities/goal_decomposition_request.dart';
import '../entities/schedule_suggestion.dart';
import '../entities/schedule_suggestion_request.dart';
import '../../../tasks/domain/entities/task.dart';

abstract class AiPlannerRepository {
  Future<AppResult<StudyPlan>> generateStudyPlan(StudyPlanRequest request);
  Future<AppResult<List<Task>>> decomposeGoal(GoalDecompositionRequest request);
  Future<AppResult<List<ScheduleSuggestion>>> suggestSchedule(
    ScheduleSuggestionRequest request,
  );
}
