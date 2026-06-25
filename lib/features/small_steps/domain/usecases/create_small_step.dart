import 'package:studyflow_ai/core/result/app_result.dart';
import '../entities/small_step.dart';
import '../repositories/small_step_repository.dart';

class CreateSmallStep {
  final SmallStepRepository _repository;

  CreateSmallStep(this._repository);

  Future<AppResult<SmallStep>> call(SmallStep step) {
    return _repository.createStep(step);
  }
}
