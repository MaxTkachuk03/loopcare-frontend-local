import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/app.dart';
import 'package:loopcare_frontend/core/application/apps_flyer/apps_flyer_service.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/application/permissions_service.dart';
import 'package:loopcare_frontend/core/application/system_service.dart';
import 'package:loopcare_frontend/core/infrastructure/app_lifecycle_observer.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_manager.dart';
import 'package:loopcare_frontend/core/presentation/localization/localization_constants.dart';
import 'package:loopcare_frontend/firebase_options.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final environment = EnvironmentType.currentType.name;
  await dotenv.load(fileName: '.env.$environment');

  await Firebase.initializeApp(
    name: 'LeanOnMe_$environment',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
  }

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await EasyLocalization.ensureInitialized();

  tz.initializeTimeZones();

  SystemService.allowOnlyPortraitOrientation();

  await AppsFlyerService.start();

  await CustomerIoService.initialize();

  await MixpanelManager().init();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  configureDependencies();

  MixpanelEventService.instance.trackVisit(
    "${AppMixpanelEvents.appStart} main",
  );

  // Todo: move to Splash Screen
  await PermissionsService.instance.requestNotificationPermissions();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  return runApp(
    EasyLocalization(
      supportedLocales: LocalizationConstants.supportedLocales,
      path: LocalizationConstants.translationsPath,
      fallbackLocale: LocalizationConstants.localeEnglish,
      saveLocale: false,
      child: const AppLifeCycleStateListener(child: App()),
    ),
  );
}
