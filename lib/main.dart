import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/app.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/application/localization/crowdin_localization_service.dart';
import 'package:loopcare_frontend/core/application/localization/localization_service.dart';
import 'package:loopcare_frontend/core/application/system_service.dart';
import 'package:loopcare_frontend/core/infrastructure/app_lifecycle_observer.dart';
import 'package:loopcare_frontend/core/infrastructure/hive_service/hive_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/country_code_service/country_code_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_manager.dart';
import 'package:loopcare_frontend/core/presentation/custom_error_widget/custom_error_widget.dart';
import 'package:loopcare_frontend/firebase_options.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final environment = EnvironmentType.currentType.name;
  await dotenv.load(fileName: '.env.$environment');

  await Firebase.initializeApp(
    name: 'LeanOnMe_$environment',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

  FlutterError.onError = _onFlutterError;

  if (!kDebugMode) {
    ErrorWidget.builder = _onFlutterErrorWidget;
  }

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = _onPlatformDispatcherError;

  tz.initializeTimeZones();

  SystemService.allowOnlyPortraitOrientation();

  await CountryCodeService.instance.init();

  await CustomerIoService.initialize();

  await MixpanelManager().init();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  configureDependencies();

  const AnalyticsEventService().init();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  await initHive();
  await CrowdinLocalizationService().initialize();
  await LocalizationService().loadLocalLocalizations();

  return runApp(const AppLifeCycleStateListener(child: App()));
}

void _onFlutterError(FlutterErrorDetails details) {
  log.e(details.exceptionAsString(), error: details.runtimeType, stackTrace: details.stack);
  FirebaseCrashlytics.instance.recordFlutterFatalError(details);
}

bool _onPlatformDispatcherError(Object error, StackTrace stackTrace) {
  log.e(error.toString(), error: error.runtimeType, stackTrace: stackTrace);
  FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  return true;
}

Widget _onFlutterErrorWidget(FlutterErrorDetails details) =>
    CustomErrorWidget(errorDetails: details);
