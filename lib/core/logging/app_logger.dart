import '../config/app_config.dart';

class AppLogger {
  AppLogger._();

  static void info(String tag, String message) {
    if (AppConfig.enableLogging) {
      // ignore: avoid_print
      print('[INFO][$tag] $message');
    }
  }

  static void warning(String tag, String message) {
    if (AppConfig.enableLogging) {
      // ignore: avoid_print
      print('[WARNING][$tag] $message');
    }
  }

  static void error(String tag, String message, [Object? error]) {
    if (AppConfig.enableLogging) {
      // ignore: avoid_print
      print('[ERROR][$tag] $message${error != null ? ' | $error' : ''}');
    }
  }
}
