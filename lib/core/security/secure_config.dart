class SecureConfig {
  SecureConfig._();

  static const String _envPrefix = 'STUDYFLOW_AI_';

  static String? get apiKey => _getEnv('${_envPrefix}API_KEY');
  static String? get aiEndpoint => _getEnv('${_envPrefix}AI_ENDPOINT');
  static String? get googleClientId => _getEnv('${_envPrefix}GOOGLE_CLIENT_ID');

  static String? _getEnv(String key) {
    // TODO: Implement proper env loading (flutter_dotenv or similar)
    return null;
  }
}
