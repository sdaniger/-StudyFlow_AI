import 'package:uuid/uuid.dart';
import '../../domain/entities/study_plan.dart';
import '../../domain/entities/study_plan_request.dart';
import '../../domain/entities/goal_decomposition_request.dart';
import '../../domain/entities/schedule_suggestion.dart';
import '../../domain/entities/schedule_suggestion_request.dart';
import '../../domain/repositories/ai_planner_repository.dart';
import '../../../../core/result/app_result.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/domain/entities/task_status.dart';
import '../../../tasks/domain/entities/task_priority.dart';

class MockAiPlannerRepository implements AiPlannerRepository {
  static const _uuid = Uuid();

  @override
  Future<AppResult<StudyPlan>> generateStudyPlan(StudyPlanRequest request) async {
    await Future.delayed(const Duration(seconds: 1));
    return AppSuccess(
      StudyPlan(
        id: _uuid.v4(),
        goal: request.goal,
        todayTasks: [
          'Review foundational concepts',
          'Complete practice problems (Set 1)',
          'Summarize key points',
        ],
        weeklyTasks: [
          'Read chapters 1-3',
          'Watch video lectures',
          'Complete practice exam',
        ],
        reviewSuggestions: [
          'Review on day 1, 3, 7, 14, 30',
        ],
        calendarSuggestions: [
          'Schedule 2h study blocks Mon/Wed/Fri',
        ],
        advice:
            'Break down your goal into small daily tasks. '
            'Focus on understanding concepts before moving to practice.',
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<AppResult<List<Task>>> decomposeGoal(
      GoalDecompositionRequest request) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final now = DateTime.now();
    return AppSuccess([
      Task(
        id: _uuid.v4(),
        title: 'Research and gather materials',
        subject: request.subject,
        status: TaskStatus.todo,
        priority: TaskPriority.high,
        estimatedMinutes: 30,
        createdByAi: true,
        createdAt: now,
        updatedAt: now,
      ),
      Task(
        id: _uuid.v4(),
        title: 'Create study outline',
        subject: request.subject,
        status: TaskStatus.todo,
        priority: TaskPriority.high,
        estimatedMinutes: 20,
        createdByAi: true,
        createdAt: now,
        updatedAt: now,
      ),
      Task(
        id: _uuid.v4(),
        title: 'Study core concepts (Part 1)',
        subject: request.subject,
        status: TaskStatus.todo,
        priority: TaskPriority.medium,
        estimatedMinutes: 60,
        createdByAi: true,
        createdAt: now,
        updatedAt: now,
      ),
      Task(
        id: _uuid.v4(),
        title: 'Practice problems',
        subject: request.subject,
        status: TaskStatus.todo,
        priority: TaskPriority.medium,
        estimatedMinutes: 45,
        createdByAi: true,
        createdAt: now,
        updatedAt: now,
      ),
      Task(
        id: _uuid.v4(),
        title: 'Review and summarize',
        subject: request.subject,
        status: TaskStatus.todo,
        priority: TaskPriority.low,
        estimatedMinutes: 15,
        createdByAi: true,
        createdAt: now,
        updatedAt: now,
      ),
    ]);
  }

  @override
  Future<AppResult<List<ScheduleSuggestion>>> suggestSchedule(
      ScheduleSuggestionRequest request) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AppSuccess([
      ScheduleSuggestion(
        taskTitle: 'Morning review',
        estimatedMinutes: 30,
        timeSlot: '08:00 - 08:30',
        reason: 'Best time for review - fresh mind',
      ),
      ScheduleSuggestion(
        taskTitle: 'Deep study session',
        estimatedMinutes: 90,
        timeSlot: '10:00 - 11:30',
        reason: 'Peak concentration hours',
      ),
      ScheduleSuggestion(
        taskTitle: 'Practice & exercises',
        estimatedMinutes: 45,
        timeSlot: '14:00 - 14:45',
        reason: 'Afternoon is good for practice',
      ),
    ]);
  }
}
