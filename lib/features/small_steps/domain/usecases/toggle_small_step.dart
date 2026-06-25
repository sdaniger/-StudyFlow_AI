import 'package:studyflow_ai/core/result/app_result.dart';
import '../entities/small_step.dart';
import '../repositories/small_step_repository.dart';

class ToggleSmallStep {
  final SmallStepRepository _repository;

  ToggleSmallStep(this._repository);

  Future<AppResult<SmallStep>> call(String stepId) {
    return _repository.toggleStep(stepId);
  }
}
