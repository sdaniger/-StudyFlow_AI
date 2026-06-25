import 'dart:io' show Platform;

class PlatformInfo {
  PlatformInfo._();

  static bool get isMobile =>
      Platform.isAndroid || Platform.isIOS;
  static bool get isDesktop =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  static bool get isWeb => false;

  static bool get isAndroid => Platform.isAndroid;
  static bool get isWindows => Platform.isWindows;
  static bool get isLinux => Platform.isLinux;
}
