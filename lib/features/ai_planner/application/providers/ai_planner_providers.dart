import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_ai_planner_repository.dart';
import '../../data/repositories/gemini_ai_planner_repository.dart';
import '../../data/repositories/openrouter_ai_planner_repository.dart';
import '../../domain/repositories/ai_planner_repository.dart';
import '../../../../core/config/app_config.dart';
import '../../../settings/application/providers/settings_providers.dart';

final aiPlannerRepositoryProvider = Provider<AiPlannerRepository>((ref) {
  if (AppConfig.useMocks) {
    return MockAiPlannerRepository();
  }
  final apiKeys = ref.watch(apiKeyConfigProvider);
  if (apiKeys.openRouterApiKey != null && apiKeys.openRouterApiKey!.isNotEmpty) {
    return OpenRouterAiPlannerRepository(apiKeys.openRouterApiKey!);
  }
  if (apiKeys.geminiApiKey != null && apiKeys.geminiApiKey!.isNotEmpty) {
    return GeminiAiPlannerRepository(apiKeys.geminiApiKey!);
  }
  return MockAiPlannerRepository();
});

