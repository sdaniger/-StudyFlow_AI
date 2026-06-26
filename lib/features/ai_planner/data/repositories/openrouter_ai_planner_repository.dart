import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../../domain/entities/study_plan.dart';
import '../../domain/entities/study_plan_request.dart';
import '../../domain/entities/goal_decomposition_request.dart';
import '../../domain/entities/schedule_suggestion.dart';
import '../../domain/entities/schedule_suggestion_request.dart';
import '../../domain/repositories/ai_planner_repository.dart';
import 'ai_prompts.dart';
import '../../../../core/result/app_result.dart';
import '../../../../core/errors/app_error.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/domain/entities/task_status.dart';
import '../../../tasks/domain/entities/task_priority.dart';

class OpenRouterAiPlannerRepository implements AiPlannerRepository {
  final String apiKey;
  static const _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  static const _model = 'openai/gpt-4o-mini';
  static const _uuid = Uuid();

  OpenRouterAiPlannerRepository(this.apiKey);

  Future<String> _callOpenRouter(String prompt) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'HTTP-Referer': 'https://studyflow.app',
        'X-Title': 'StudyFlow AI',
      },
      body: jsonEncode({
        'model': _model,
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a study task management assistant. Respond with valid JSON only, no markdown.',
          },
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.3,
        'max_tokens': 2048,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'OpenRouter API error ${response.statusCode}: ${response.body}');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final content =
        body['choices']?[0]?['message']?['content'] as String?;
    if (content == null) {
      throw Exception('OpenRouter: no content in response');
    }
    return content;
  }

  @override
  Future<AppResult<StudyPlan>> generateStudyPlan(
      StudyPlanRequest request) async {
    try {
      final prompt = studyPlanPrompt(
        request.goal,
        request.subject,
        request.difficulty,
        request.concerns,
      );
      final text = await _callOpenRouter(prompt);
      final json = jsonDecode(text) as Map<String, dynamic>;
      final plan = StudyPlan(
        id: _uuid.v4(),
        goal: json['goal'] as String? ?? request.goal,
        todayTasks: (json['todayTasks'] as List?)?.cast<String>() ?? [],
        weeklyTasks: (json['weeklyTasks'] as List?)?.cast<String>() ?? [],
        reviewSuggestions:
            (json['reviewSuggestions'] as List?)?.cast<String>() ?? [],
        calendarSuggestions:
            (json['calendarSuggestions'] as List?)?.cast<String>() ?? [],
        advice: json['advice'] as String? ?? '',
        createdAt: DateTime.now(),
      );
      return AppSuccess(plan);
    } catch (e) {
      return AppFailure(AiApiError('OpenRouter: ${e.toString()}'));
    }
  }

  @override
  Future<AppResult<List<Task>>> decomposeGoal(
      GoalDecompositionRequest request) async {
    try {
      final prompt = decomposeGoalPrompt(request.goal, request.subject);
      final text = await _callOpenRouter(prompt);
      final jsonList = jsonDecode(text) as List;
      final now = DateTime.now();
      final tasks = jsonList.map((j) {
        final m = j as Map<String, dynamic>;
        return Task(
          id: _uuid.v4(),
          title: m['title'] as String? ?? 'Untitled',
          subject: m['subject'] as String? ?? request.subject,
          status: TaskStatus.todo,
          priority: _parsePriority(m['priority'] as String?),
          estimatedMinutes: m['estimatedMinutes'] as int?,
          createdByAi: true,
          createdAt: now,
          updatedAt: now,
        );
      }).toList();
      return AppSuccess(tasks);
    } catch (e) {
      return AppFailure(AiApiError('OpenRouter: ${e.toString()}'));
    }
  }

  @override
  Future<AppResult<List<ScheduleSuggestion>>> suggestSchedule(
      ScheduleSuggestionRequest request) async {
    try {
      final prompt = _schedulePrompt(request);
      final text = await _callOpenRouter(prompt);
      final jsonList = jsonDecode(text) as List;
      final list = jsonList.map((j) {
        final m = j as Map<String, dynamic>;
        return ScheduleSuggestion(
          taskTitle: m['taskTitle'] as String? ?? '',
          estimatedMinutes: (m['estimatedMinutes'] as num?)?.toInt() ?? 30,
          timeSlot: m['timeSlot'] as String?,
          reason: m['reason'] as String? ?? '',
        );
      }).toList();
      return AppSuccess(list);
    } catch (e) {
      return AppFailure(AiApiError('OpenRouter: ${e.toString()}'));
    }
  }

  @override
  Future<AppResult<List<Task>>> suggestTasksFromText(String text) async {
    try {
      final prompt = taskSuggestionPrompt(text);
      final response = await _callOpenRouter(prompt);
      final jsonList = jsonDecode(response) as List;
      final now = DateTime.now();
      final tasks = jsonList.map((j) {
        final m = j as Map<String, dynamic>;
        return Task(
          id: _uuid.v4(),
          title: m['title'] as String? ?? text,
          subject: m['subject'] as String?,
          status: TaskStatus.todo,
          priority: _parsePriority(m['priority'] as String?),
          estimatedMinutes: (m['estimatedMinutes'] as num?)?.toInt(),
          createdByAi: true,
          createdAt: now,
          updatedAt: now,
        );
      }).toList();
      return AppSuccess(tasks);
    } catch (e) {
      return AppFailure(AiApiError('OpenRouter: ${e.toString()}'));
    }
  }

  String _schedulePrompt(ScheduleSuggestionRequest request) {
    return '''You are a scheduling assistant. Given the following task IDs, suggest an optimal daily schedule.
Return a JSON array of:
{
  "taskTitle": "string",
  "estimatedMinutes": number,
  "timeSlot": "HH:MM - HH:MM",
  "reason": "string"
}

Task IDs: ${request.taskIds.join(', ')}
${request.date != null ? 'Date: ${request.date!.toIso8601String()}' : ''}

Return ONLY the JSON array.
''';
  }

  TaskPriority _parsePriority(String? p) {
    switch (p?.toLowerCase()) {
      case 'urgent':
        return TaskPriority.urgent;
      case 'high':
        return TaskPriority.high;
      case 'medium':
        return TaskPriority.medium;
      default:
        return TaskPriority.low;
    }
  }
}
