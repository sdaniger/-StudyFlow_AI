import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/api_key_config.dart';

final apiKeyConfigProvider = StateNotifierProvider<ApiKeyConfigNotifier, ApiKeyConfig>((ref) {
  return ApiKeyConfigNotifier();
});

class ApiKeyConfigNotifier extends StateNotifier<ApiKeyConfig> {
  ApiKeyConfigNotifier() : super(const ApiKeyConfig());

  void setGeminiKey(String key) {
    state = state.copyWith(geminiApiKey: key.isNotEmpty ? key : null);
  }

  void setOpenRouterKey(String key) {
    state = state.copyWith(openRouterApiKey: key.isNotEmpty ? key : null);
  }

  bool get hasAnyKey => state.geminiApiKey != null || state.openRouterApiKey != null;
  bool get hasGeminiKey => state.geminiApiKey != null && state.geminiApiKey!.isNotEmpty;
  bool get hasOpenRouterKey => state.openRouterApiKey != null && state.openRouterApiKey!.isNotEmpty;
}
