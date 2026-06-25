import 'package:studyflow_ai/core/result/app_result.dart';
import '../entities/small_step.dart';
import '../repositories/small_step_repository.dart';

class GetStepsForTask {
  final SmallStepRepository _repository;

  GetStepsForTask(this._repository);

  Future<AppResult<List<SmallStep>>> call(String taskId) {
    return _repository.getStepsForTask(taskId);
  }
}
