import 'package:flutter_test/flutter_test.dart';
import 'package:studyflow_ai/features/ai_planner/data/repositories/mock_ai_planner_repository.dart';
import 'package:studyflow_ai/features/ai_planner/domain/entities/study_plan_request.dart';
import 'package:studyflow_ai/features/ai_planner/domain/entities/goal_decomposition_request.dart';
import 'package:studyflow_ai/core/result/app_result.dart';

void main() {
  late MockAiPlannerRepository repository;

  setUp(() {
    repository = MockAiPlannerRepository();
  });

  group('MockAiPlannerRepository', () {
    test('generateStudyPlan returns plan', () async {
      final request = StudyPlanRequest(
        goal: 'Pass JLPT N3',
        dailyStudyMinutes: 120,
        subject: 'Japanese',
      );

      final result = await repository.generateStudyPlan(request);
      expect(result, isA<AppSuccess>());

      final plan = (result as AppSuccess).data;
      expect(plan.goal, 'Pass JLPT N3');
      expect(plan.todayTasks.isNotEmpty, true);
      expect(plan.weeklyTasks.isNotEmpty, true);
      expect(plan.advice.isNotEmpty, true);
    });

    test('decomposeGoal returns task list', () async {
      final request = GoalDecompositionRequest(
        goal: 'Learn calculus',
        subject: 'Mathematics',
      );

      final result = await repository.decomposeGoal(request);
      expect(result, isA<AppSuccess>());

      final tasks = (result as AppSuccess).data;
      expect(tasks.length, 5);
      expect(tasks.first.title.isNotEmpty, true);
    });
  });
}
