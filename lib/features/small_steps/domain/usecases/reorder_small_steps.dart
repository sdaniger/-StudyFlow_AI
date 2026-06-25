import 'package:studyflow_ai/core/result/app_result.dart';
import '../entities/small_step.dart';
import '../repositories/small_step_repository.dart';

class ReorderSmallSteps {
  final SmallStepRepository _repository;

  ReorderSmallSteps(this._repository);

  Future<AppResult<List<SmallStep>>> call(String taskId, List<String> stepIds) {
    return _repository.reorderSteps(taskId, stepIds);
  }
}
