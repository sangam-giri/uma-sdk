enum LogLevel { debug, info, warning, error }

//ANSI escape code
class ANSIEscapeCode {
  static String get white => '\x1B[37m';
  static String get grey => '\x1B[90m';
  static String get green => '\x1B[32m';
  static String get blue => '\x1B[34m';
  static String get red => '\x1B[31m';
  static String get yellow => '\x1B[33m';
  static String get reset => '\x1B[0m';
}

class Logger {
  LogLevel _minLevel;

  Logger({LogLevel minLevel = LogLevel.debug}) : _minLevel = minLevel;

  void log(LogLevel level, String message) {
    if (level.index >= _minLevel.index) {
      final prefix = _getPrefix(level);
      final color = _getColor(level);
      // final timestamp = DateTime.now();
      DateTime now = DateTime.now();
      String timestamp =
          '${now.year}-${_formatTwoDigits(now.month)}-${_formatTwoDigits(now.day)} '
          '${_formatTwoDigits(now.hour)}:${_formatTwoDigits(now.minute)}:${_formatTwoDigits(now.second)}';
      print(
          '${ANSIEscapeCode.grey}[$timestamp]${ANSIEscapeCode.reset} $color$prefix${ANSIEscapeCode.reset}${ANSIEscapeCode.white} : $message${ANSIEscapeCode.reset}');
    }
  }

  ///Function to format digits to two digits with leading zeros
  String _formatTwoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  String _getPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warning:
        return 'WARNING';
      case LogLevel.error:
        return 'ERROR';
      default:
        return '';
    }
  }

  String _getColor(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return ANSIEscapeCode.blue; // Blue
      case LogLevel.info:
        // return ANSIEscapeCode.green; // Green
        return ANSIEscapeCode.blue; // Blue
      case LogLevel.warning:
        return ANSIEscapeCode.yellow; // Yellow
      case LogLevel.error:
        return ANSIEscapeCode.red; // Red
      default:
        return '';
    }
  }

  void debug(String message) => log(LogLevel.debug, message);

  void info(String message) => log(LogLevel.info, message);

  void warning(String message) => log(LogLevel.warning, message);

  void error(String message) => log(LogLevel.error, message);
}
