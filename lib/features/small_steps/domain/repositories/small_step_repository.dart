import 'package:studyflow_ai/core/result/app_result.dart';
import '../entities/small_step.dart';

abstract class SmallStepRepository {
  Future<AppResult<List<SmallStep>>> getStepsForTask(String taskId);
  Future<AppResult<SmallStep>> createStep(SmallStep step);
  Future<AppResult<SmallStep>> updateStep(SmallStep step);
  Future<AppResult<void>> deleteStep(String stepId);
  Future<AppResult<SmallStep>> toggleStep(String stepId);
  Future<AppResult<List<SmallStep>>> reorderSteps(String taskId, List<String> stepIds);
}
