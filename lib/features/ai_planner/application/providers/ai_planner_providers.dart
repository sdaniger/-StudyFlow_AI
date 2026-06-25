import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_ai_planner_repository.dart';
import '../../domain/repositories/ai_planner_repository.dart';
import '../../../../core/config/app_config.dart';

final aiPlannerRepositoryProvider = Provider<AiPlannerRepository>((ref) {
  if (AppConfig.useMocks) {
    return MockAiPlannerRepository();
  }
  return MockAiPlannerRepository();
});
