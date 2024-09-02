import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/country_code_service/country_code_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localization_constants.dart';

GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

final BuildContext kOverlayContext = kNavigatorKey.currentState!.overlay!.context;

@singleton
class AppConfig {
  String get projectName => 'LeanOnMe';

  String get baseUrl => CountryCodeService.instance.useUsServer
      ? dotenv.env['BASE_URL'] ?? ""
      : dotenv.env['BASE_URL_EU'] ?? "";

  String get region => CountryCodeService.instance.localRegion;

  String get language => LocalizationConstants.localeLanguageCode();

  String get baseHost => Uri.parse(baseUrl).host;

  String get version => Constants.apiVersion;
}
