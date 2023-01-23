import 'package:injectable/injectable.dart';

@singleton
class AppConfig {
  String get projectName => 'LeanOnMe';

  String get baseUrl => 'https://dev.loopcare.app';
}
