import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/presentation/localization/localization_constants.dart';

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

final BuildContext kOverlayContext = kNavigatorKey.currentState!.overlay!.context;

@singleton
class AppConfig {
  String get projectName => 'LeanOnMe';

  String get baseUrl =>
      LocalizationConstants.useUsServer ? dotenv.env['BASE_URL'] ?? "" : dotenv.env['BASE_URL_EU'] ?? "";

  String get baseHost => Uri.parse(baseUrl).host;

  String get appStoreSettingsLink => 'https://apps.apple.com/account/subscriptions';

  String get playMarketSettingsLink => 'https://play.google.com/store/account/subscriptions';
}
