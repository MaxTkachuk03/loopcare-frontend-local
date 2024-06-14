import 'package:logger/logger.dart';
import 'package:loopcare_frontend/build_type.dart';

final log = Logger(
  printer: PrettyPrinter(),
  filter: DevelopmentEnvironmentFilter(),
);

class DevelopmentEnvironmentFilter extends LogFilter {
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