class ApiKeyConfig {
  final String? geminiApiKey;
  final String? openRouterApiKey;

  const ApiKeyConfig({this.geminiApiKey, this.openRouterApiKey});

  ApiKeyConfig copyWith({String? geminiApiKey, String? openRouterApiKey}) {
    return ApiKeyConfig(
      geminiApiKey: geminiApiKey ?? this.geminiApiKey,
      openRouterApiKey: openRouterApiKey ?? this.openRouterApiKey,
    );
  }
}
