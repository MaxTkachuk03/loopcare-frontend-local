import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/country_code_service/country_code_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/stored_account_service/stored_account_service.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_content_type.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';

class AnalyticsEventService {
  static final instance = AnalyticsEventService._();

  AnalyticsEventService._();

  void logEvent(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    final userId = StoredAccountService.getAccount()?.id ?? -1;

    final userIdPrefix = CountryCodeService.instance.serverCountryCode;

    Map<String, Object> tmpParameters = Map.from(parameters ?? {});
    tmpParameters[CustomDefinitions.userId] = '$userId-$userIdPrefix';

    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: tmpParameters,
    );
  }

  void logFoodPreferencesEvent(
    String eventName,
    IList<String> selectedHatesNames,
    IList<String> selectedAllergicNames,
    IList<String> selectedDislikesNames,
  ) async {
    logFoodPreferencesHateEvent(eventName, selectedHatesNames);
    logFoodPreferencesAllergicEvent(eventName, selectedAllergicNames);
    logFoodPreferencesDislikeEvent(eventName, selectedDislikesNames);
  }

  void logFoodPreferencesHateEvent(
    String eventName,
    IList<String> selectedHatesNames,
  ) async {
    for (var item in selectedHatesNames) {
      logEvent(
        '${eventName}_${CustomDefinitions.hated}',
        parameters: {
          CustomDefinitions.hated: item.toString(),
        },
      );
    }
  }

  void logFoodPreferencesAllergicEvent(
    String eventName,
    IList<String> selectedAllergicNames,
  ) async {
    for (var item in selectedAllergicNames) {
      logEvent(
        '${eventName}_${CustomDefinitions.allergic}',
        parameters: {
          CustomDefinitions.allergic: item.toString(),
        },
      );
    }
  }

  void logFoodPreferencesDislikeEvent(
    String eventName,
    IList<String> selectedDislikeNames,
  ) async {
    for (var item in selectedDislikeNames) {
      logEvent(
        '${eventName}_${CustomDefinitions.dislike}',
        parameters: {
          CustomDefinitions.dislike: item.toString(),
        },
      );
    }
  }

  void logLessonCompletedEvent(
    String eventName,
    int lessonId,
  ) async {
    logEvent(
      eventName,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
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
      eventName,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.lessonType: contentType.name,
        CustomDefinitions.title: lessonTitle,
        // CustomDefinitions.withAudio: lesson.type == LessonContentType.audio ? 'true' : 'false',
        CustomDefinitions.withQuiz: withQuiz ? 'true' : 'false',
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void openedTextLessonVersionEvent(int lessonId) async {
    logEvent(
      FirebaseEvents.openedTextLessonVersion,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void closedTextLessonVersionEvent(int lessonId) async {
    logEvent(
      FirebaseEvents.closedTextLessonVersion,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioPlayEvent(int lessonId) async {
    logEvent(
      FirebaseEvents.lessonAudioPlay,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioStopEvent(int lessonId) async {
    logEvent(
      FirebaseEvents.lessonAudioStop,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioFinishedEvent(int lessonId) async {
    logEvent(
      FirebaseEvents.lessonAudioFinished,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
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
      eventName,
      parameters: {
        CustomDefinitions.assessmentLevel: score,
        CustomDefinitions.assessmentLike: assessmentLike,
        CustomDefinitions.programId: programId.toString(),
      },
    );
  }

  void logPhysicalProgramEvent(
    String eventName,
    PhysicalProgram program,
  ) async {
    logEvent(
      eventName,
      parameters: {
        CustomDefinitions.programId: program.id,
        CustomDefinitions.programName: program.name,
        CustomDefinitions.programDuration: program.duration,
        CustomDefinitions.programDifficulty: program.difficultyName,
      },
    );
  }

  void logPhysicalActivityVideoEvent(
    String eventName,
    PhysicalProgram program,
    PhysicalProgramExercise exercise,
  ) async {
    logEvent(
      eventName,
      parameters: {
        CustomDefinitions.programId: program.id,
        CustomDefinitions.programName: program.name,
        CustomDefinitions.programDuration: program.duration,
        CustomDefinitions.programDifficulty: program.difficultyName,
        CustomDefinitions.exercise: exercise.name,
        CustomDefinitions.exerciseDuration: exercise.duration,
        CustomDefinitions.exerciseLink: exercise.video ?? '',
      },
    );
  }

  void openedSessionPreparationMaterialsEvent(int sessionId, String weekTopic) async {
    logEvent(
      FirebaseEvents.openedSessionPreparationMaterials,
      parameters: {
        CustomDefinitions.sessionId: sessionId.toString(),
        CustomDefinitions.weekTopic: weekTopic,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void closedSessionPreparationMaterialsEvent(int sessionId, String weekTopic) async {
    logEvent(
      FirebaseEvents.closedSessionPreparationMaterials,
      parameters: {
        CustomDefinitions.sessionId: sessionId.toString(),
        CustomDefinitions.weekTopic: weekTopic,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void userOpenedAssignment(Reflection question) async {
    logEvent(
      FirebaseEvents.userOpenedAssignment,
      parameters: {
        CustomDefinitions.assignmentId: question.id.toString(),
        CustomDefinitions.assignmentTitle: question.title,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void finalizeAssignment(
    String event,
    Reflection reflection,
    bool fromDashboard,
  ) async {
    logEvent(
      event,
      parameters: {
        CustomDefinitions.assignmentId: reflection.id,
        CustomDefinitions.assignmentTitle: reflection.title,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
        CustomDefinitions.navigatedFrom: fromDashboard ? 'Dashboard' : 'My assignments',
      },
    );
  }

  void assignmentMotivationScale(
    String value,
    Reflection reflection,
    bool fromDashboard,
  ) async {
    logEvent(
      FirebaseEvents.assignmentMotivationScale,
      parameters: {
        CustomDefinitions.value: value,
        CustomDefinitions.assignmentId: reflection.id,
        CustomDefinitions.assignmentTitle: reflection.title,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
        CustomDefinitions.navigatedFrom: fromDashboard ? 'Dashboard' : 'My assignments',
      },
    );
  }
}
