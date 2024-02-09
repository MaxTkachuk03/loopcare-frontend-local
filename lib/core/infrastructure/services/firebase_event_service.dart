import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_list.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_page.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';

class AnalyticsEventService {
  AuthenticationCubit? get _authenticationCubit => GetIt.instance<AuthenticationCubit>();

  static final instance = AnalyticsEventService._();

  AnalyticsEventService._();

  void logEvent(String eventName, {Map<String, dynamic>? parameters}) async {
    final userId = _authenticationCubit?.state.id ?? -1;

    if (parameters != null) {
      parameters[CustomDefinitions.userId] = userId;
    } else {
      parameters = {CustomDefinitions.userId: userId};
    }

    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: parameters,
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

  void logLessonCompletedEvent(String eventName, int lessonId) async {
    FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
      },
    );
  }

  void logLessonEvent(
    String eventName,
    int lessonId,
    LessonPage lesson,
  ) async {
    logEvent(
      eventName,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.lessonType: lesson.type.name,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void openedTextLessonVersionEvent(int lessonId, int userId) async {
    logEvent(
      FirebaseEvents.openedTextLessonVersion,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void closedTextLessonVersionEvent(int lessonId, int userId) async {
    logEvent(
      FirebaseEvents.closedTextLessonVersion,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioPlayEvent(int lessonId, int userId) async {
    logEvent(
      FirebaseEvents.lessonAudioPlay,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioStopEvent(int lessonId, int userId) async {
    logEvent(
      FirebaseEvents.lessonAudioStop,
      parameters: {
        CustomDefinitions.lessonId: lessonId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioFinishedEvent(int lessonId, int userId) async {
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
  ) async {
    logEvent(
      eventName,
      parameters: {
        CustomDefinitions.assessmentLevel: score,
        CustomDefinitions.assessmentLike: assessmentLike,
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

  void openedSessionPreparationMaterialsEvent(int userId, int sessionId) async {
    logEvent(
      FirebaseEvents.openedSessionPreparationMaterials,
      parameters: {
        CustomDefinitions.sessionId: sessionId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  void closedSessionPreparationMaterialsEvent(int userId, int sessionId) async {
    logEvent(
      FirebaseEvents.closedSessionPreparationMaterials,
      parameters: {
        CustomDefinitions.sessionId: sessionId.toString(),
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }
}
