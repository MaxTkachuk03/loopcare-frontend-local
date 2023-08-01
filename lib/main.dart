import 'dart:async';
import 'package:timezone/data/latest.dart' as tz;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:loopcare_frontend/core/app.dart';
import 'package:loopcare_frontend/core/presentation/localization/localization_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loopcare_frontend/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const environment = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  await dotenv.load(fileName: '.env.$environment');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();

  tz.initializeTimeZones();

  // final byteData = await rootBundle.load('local_plugins/timezone/lib/data/latest.tzf');
  // tz.initializeDatabase(byteData.buffer.asUint8List());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

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
