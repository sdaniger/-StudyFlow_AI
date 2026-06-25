import 'package:studyflow_ai/core/result/app_result.dart';
import '../repositories/small_step_repository.dart';

class DeleteSmallStep {
  final SmallStepRepository _repository;

  DeleteSmallStep(this._repository);

  Future<AppResult<void>> call(String stepId) {
    return _repository.deleteStep(stepId);
  }
}
