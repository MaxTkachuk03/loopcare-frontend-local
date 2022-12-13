import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:loopcare_frontend/core/app.dart';
import 'package:loopcare_frontend/core/presentation/localization/localization_constants.dart';
import 'package:loopcare_frontend/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  configureDependencies();

  return runApp(
    EasyLocalization(
      supportedLocales: LocalizationConstants.supportedLocales,
      path: LocalizationConstants.translationsPath,
      fallbackLocale: LocalizationConstants.localeEnglish,
      saveLocale: false,
      child: const App(),
    ),
  );
}
