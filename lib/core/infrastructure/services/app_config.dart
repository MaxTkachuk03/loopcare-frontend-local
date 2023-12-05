import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppConfig {
  String get projectName => 'LeanOnMe';

  String get baseUrl => dotenv.env['BASE_URL'] ?? "";

  String get baseHost => Uri.parse(dotenv.env['BASE_URL'] ?? "").host;

  String get appStoreSettingsLink => 'https://apps.apple.com/account/subscriptions';

  String get playMarketSettingsLink => 'https://play.google.com/store/account/subscriptions';
}
