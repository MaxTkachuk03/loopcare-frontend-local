import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

final BuildContext kOverlayContext = kNavigatorKey.currentState!.overlay!.context;

@singleton
class AppConfig {
  String get projectName => 'LeanOnMe';

  String get baseUrl => dotenv.env['BASE_URL'] ?? "";

  String get baseHost => Uri.parse(dotenv.env['BASE_URL'] ?? "").host;
}
