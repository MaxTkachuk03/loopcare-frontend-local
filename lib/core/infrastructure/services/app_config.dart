import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@singleton
class AppConfig {
  String get projectName => 'LeanOnMe';

  String get baseUrl => dotenv.env['BASE_URL'] ?? "";
}
