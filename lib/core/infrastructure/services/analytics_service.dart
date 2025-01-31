import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/apps_flyer_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/country_code_service/country_code_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/infrastructure/services/stored_account_service/stored_account_service.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_content_type.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';

class AnalyticsEventService {
  final bool _includeAppsFlyer;
  final bool _includeFbAnalytics;
  final bool _includeUXcam;

  String get userId {
    final accountId = StoredAccountService.getAccount()?.id ?? -1;
    final userIdPrefix = CountryCodeService.instance.serverCountryCode;
    final id = '$accountId-$userIdPrefix';
    return id;
  }

  const AnalyticsEventService.appsFlyer()
      : _includeAppsFlyer = true,
        _includeFbAnalytics = false,
        _includeUXcam = false;

  const AnalyticsEventService.firebase()
      : _includeFbAnalytics = true,
        _includeAppsFlyer = false,
        _includeUXcam = false;

  const AnalyticsEventService.uxcam()
      : _includeFbAnalytics = false,
        _includeAppsFlyer = false,
        _includeUXcam = true;

  const AnalyticsEventService({bool includeAppsFlyer = false})
      : _includeAppsFlyer = includeAppsFlyer,
        _includeFbAnalytics = true,
        _includeUXcam = true;

  void logEvent({
    required String eventName,
    Map<String, dynamic>? parameters,
  }) async {
    if (_includeFbAnalytics) {
      await _firebaseLogEvent(eventName, parameters);
    }

    if (_includeAppsFlyer && kIsProd) {
      await _appsFlyerLogEvent(eventName, parameters);
    }

    if (_includeUXcam) {
      await _uxcamLogEvent(eventName, parameters);
    }
  }

  void logScreenEvent(String screenName) async {
    if (_includeFbAnalytics) {
      await _firebaseLogEvent('screen_view', {'screenName': screenName});
    }

    if (_includeAppsFlyer && kIsProd) {
      await _appsFlyerLogEvent('screen_view', {'screenName': screenName});
    }

    if (_includeUXcam) {
      FlutterUxcam.tagScreenName(screenName);
    }
  }

  Future<void> _appsFlyerLogEvent(
    String eventName,
    Map<String, dynamic>? parameters,
  ) async {
    Map<String, Object> tmpParameters = Map.from(parameters ?? {});
    Map<String, dynamic> args = tmpParameters.map((key, value) => MapEntry('af_$key', value));
    args[AnalyticsParameters.userId] = 'af_$userId';

    try {
      await AppsFlyerService.appsflyerSdk.logEvent('af_$eventName', args);
    } on Exception catch (error) {
      log.e(error.toString(), error: error.runtimeType);
    }
  }

  Future<void> _firebaseLogEvent(
    String eventName,
    Map<String, dynamic>? parameters,
  ) async {
    Map<String, Object> tmpParameters = Map.from(parameters ?? {});
    tmpParameters[AnalyticsParameters.userId] = userId;

    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: tmpParameters,
    );
  }

  Future<void> _uxcamLogEvent(
    String eventName,
    Map<String, dynamic>? parameters,
  ) async {
    Map<String, Object> tmpParameters = Map.from(parameters ?? {});
    tmpParameters[AnalyticsParameters.userId] = userId;

    FlutterUxcam.logEventWithProperties(eventName, parameters ?? {});
  }

  Future<void> init() async {
    if (kIsDev || kDebugMode) return;

    FlutterUxcam.optIntoSchematicRecordings();
    FlutterUxConfig config = FlutterUxConfig(userAppKey: dotenv.env['UXCAM_APP_KEY'] ?? '');
    await FlutterUxcam.startWithConfiguration(config);
  }

  void logFoodPreferencesEvent(
    String eventName,
    List<String> selectedHatesNames,
    List<String> selectedAllergicNames,
    List<String> selectedDislikesNames,
  ) async {
    logFoodPreferencesHateEvent(eventName, selectedHatesNames);
    logFoodPreferencesAllergicEvent(eventName, selectedAllergicNames);
    logFoodPreferencesDislikeEvent(eventName, selectedDislikesNames);
  }

  void logFoodPreferencesHateEvent(String eventName, List<String> selectedHatesNames) async {
    for (var item in selectedHatesNames) {
      logEvent(
        eventName: '${eventName}_${AnalyticsParameters.hated}',
        parameters: {
          AnalyticsParameters.hated: item.toString(),
        },
      );
    }
  }

  void logFoodPreferencesAllergicEvent(
    String eventName,
    List<String> selectedAllergicNames,
  ) async {
    for (var item in selectedAllergicNames) {
      logEvent(
        eventName: '${eventName}_${AnalyticsParameters.allergic}',
        parameters: {
          AnalyticsParameters.allergic: item.toString(),
        },
      );
    }
  }

  void logFoodPreferencesDislikeEvent(
    String eventName,
    List<String> selectedDislikeNames,
  ) async {
    for (var item in selectedDislikeNames) {
      logEvent(
        eventName: '${eventName}_${AnalyticsParameters.dislike}',
        parameters: {
          AnalyticsParameters.dislike: item.toString(),
        },
      );
    }
  }

  void logLessonCompletedEvent(
    String eventName,
    int lessonId,
  ) async {
    logEvent(
      eventName: eventName,
      parameters: {
        AnalyticsParameters.lessonId: lessonId.toString(),
      },
    );
  }

  void logLessonEvent(
    String eventName,
    int lessonId,
    LessonContentType contentType,
    String lessonTitle,
    bool withQuiz,
  ) async {
    logEvent(
      eventName: eventName,
      parameters: {
        AnalyticsParameters.lessonId: lessonId.toString(),
        AnalyticsParameters.lessonType: contentType.name,
        AnalyticsParameters.title: lessonTitle,
        // AnalyticsParameters.withAudio: lesson.type == LessonContentType.audio ? 'true' : 'false',
        AnalyticsParameters.withQuiz: withQuiz ? 'true' : 'false',
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void logILessonEvent(
    String eventName,
    int iLessonId,
    String iLessonTitle,
    int moduleId,
    String moduleTitle,
  ) async {
    logEvent(
      eventName: eventName,
      parameters: {
        AnalyticsParameters.iLessonId: iLessonId.toString(),
        AnalyticsParameters.iLessonTitle: iLessonTitle,
        AnalyticsParameters.iLessonModuleId: moduleId,
        AnalyticsParameters.iLessonModuleTitle: moduleTitle
      },
    );
  }

  void openedTextLessonVersionEvent(int lessonId) async {
    logEvent(
      eventName: AnalyticsEvents.openedTextLessonVersion,
      parameters: {
        AnalyticsParameters.lessonId: lessonId.toString(),
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void closedTextLessonVersionEvent(int lessonId) async {
    logEvent(
      eventName: AnalyticsEvents.closedTextLessonVersion,
      parameters: {
        AnalyticsParameters.lessonId: lessonId.toString(),
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioPlayEvent(int lessonId) async {
    logEvent(
      eventName: AnalyticsEvents.lessonAudioPlay,
      parameters: {
        AnalyticsParameters.lessonId: lessonId.toString(),
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioStopEvent(int lessonId) async {
    logEvent(
      eventName: AnalyticsEvents.lessonAudioStop,
      parameters: {
        AnalyticsParameters.lessonId: lessonId.toString(),
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioFinishedEvent(int lessonId) async {
    logEvent(
      eventName: AnalyticsEvents.lessonAudioFinished,
      parameters: {
        AnalyticsParameters.lessonId: lessonId.toString(),
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void logProgramAssessmentEvent(
    String eventName,
    int score,
    String assessmentLike,
    int programId,
  ) async {
    logEvent(
      eventName: eventName,
      parameters: {
        AnalyticsParameters.assessmentLevel: score,
        AnalyticsParameters.assessmentLike: assessmentLike,
        AnalyticsParameters.programId: programId.toString(),
      },
    );
  }

  void logPhysicalProgramEvent(
    String eventName,
    PhysicalProgram program,
  ) async {
    logEvent(
      eventName: eventName,
      parameters: {
        AnalyticsParameters.programId: program.id,
        AnalyticsParameters.programName: program.name,
        AnalyticsParameters.programDuration: program.duration,
        AnalyticsParameters.programDifficulty: program.difficultyName,
      },
    );
  }

  void logPhysicalActivityVideoEvent(
    String eventName,
    PhysicalProgram program,
    PhysicalProgramExercise exercise,
  ) async {
    logEvent(
      eventName: eventName,
      parameters: {
        AnalyticsParameters.programId: program.id,
        AnalyticsParameters.programName: program.name,
        AnalyticsParameters.programDuration: program.duration,
        AnalyticsParameters.programDifficulty: program.difficultyName,
        AnalyticsParameters.exercise: exercise.name,
        AnalyticsParameters.exerciseDuration: exercise.duration,
        AnalyticsParameters.exerciseLink: exercise.video ?? '',
      },
    );
  }

  void openedSessionPreparationMaterialsEvent(int sessionId, String weekTopic) async {
    logEvent(
      eventName: AnalyticsEvents.openedSessionPreparationMaterials,
      parameters: {
        AnalyticsParameters.sessionId: sessionId.toString(),
        AnalyticsParameters.weekTopic: weekTopic,
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void closedSessionPreparationMaterialsEvent(int sessionId, String weekTopic) async {
    logEvent(
      eventName: AnalyticsEvents.closedSessionPreparationMaterials,
      parameters: {
        AnalyticsParameters.sessionId: sessionId.toString(),
        AnalyticsParameters.weekTopic: weekTopic,
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void userOpenedAssignment(Reflection question) async {
    logEvent(
      eventName: AnalyticsEvents.userOpenedReflection,
      parameters: {
        AnalyticsParameters.reflectionId: question.id.toString(),
        AnalyticsParameters.reflectionTitle: question.title,
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void finalizeAssignment(
    String event,
    Reflection reflection,
    bool fromDashboard,
  ) async {
    logEvent(
      eventName: event,
      parameters: {
        AnalyticsParameters.reflectionId: reflection.id,
        AnalyticsParameters.reflectionTitle: reflection.title,
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        AnalyticsParameters.navigatedFrom: fromDashboard ? 'Dashboard' : 'My assignments',
      },
    );
  }

  void assignmentMotivationScale(
    String value,
    Reflection reflection,
    bool fromDashboard,
  ) async {
    logEvent(
      eventName: AnalyticsEvents.reflectionMotivationScale,
      parameters: {
        AnalyticsParameters.value: value,
        AnalyticsParameters.reflectionId: reflection.id,
        AnalyticsParameters.reflectionTitle: reflection.title,
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        AnalyticsParameters.navigatedFrom: fromDashboard ? 'Dashboard' : 'My assignments',
      },
    );
  }
}
