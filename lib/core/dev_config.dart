class DevConfig {
  static final DevConfig _singleton = DevConfig._instance();

  factory DevConfig() {
    return _singleton;
  }

  DevConfig._instance();

  /// Show console logs or not
  ///
  /// This will show all the logs in the console
  static bool get showConsoleLogs => false;

  /// Show console prints or not
  ///
  /// this will limit the number of logged line in the console
  static bool get showConsolePrints => true;

  /// Save logs to file or not
  static bool get saveLogsToFile => true;
}
