import 'package:logger/logger.dart';
import 'package:loopcare_frontend/build_type.dart';

final log = AppLogger();

class AppLogger {
  final _log = Logger(
    printer: PrettyPrinter(),
    filter: _DevelopmentEnvironmentFilter(),
  );

  void e(dynamic message, {Object? error, StackTrace? stackTrace}) =>
      _log.e(message, error: error, time: DateTime.timestamp(), stackTrace: stackTrace);

  void w(dynamic message, {Object? error}) =>
      _log.w(message, error: error, time: DateTime.timestamp());

  void i(dynamic message, {Object? error}) =>
      _log.i(message, error: error, stackTrace: StackTrace.empty);
}

class _DevelopmentEnvironmentFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    bool shouldLog = false;
    if (event.level.value >= level!.value) {
      shouldLog = true;
    }

    return !kIsProd && shouldLog;
  }
}

class LogTitle {
  static const String noItem = 'NO ITEM';
  static const String parsingError = 'PARSING ERROR';
  static const String subscription = 'SUBSCRIPTION';
}