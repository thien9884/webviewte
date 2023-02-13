import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogUtils {
  static final _logger = Logger(
    level: logLevel(),
    printer: PrettyPrinter(
      methodCount: 0,
      lineLength: 150,
      printTime: true,
      printEmojis: true,
    ),
  );

  static Level logLevel() {
    if (kReleaseMode) {
      return Level.nothing;
    }
    return Level.verbose;
  }

  void info(dynamic message) => _logger.i('[INFO] $message');

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e('[ERROR] $message', error, stackTrace);

  String i(String msg) {
    debugPrint('[LOG INFO] - $msg');
    return msg;
  }
}
