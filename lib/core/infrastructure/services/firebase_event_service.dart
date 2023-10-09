import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_page.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';

class AnalyticsEventService {
  static final instance = AnalyticsEventService._();

  AnalyticsEventService._();

  void logEvent(String eventName, {Map<String, dynamic>? data}) async {
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: data,
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
      await FirebaseAnalytics.instance
          .logEvent(name: '${eventName}_hated', parameters: {'hated': item.toString()});
    }
  }

  void logFoodPreferencesAllergicEvent(
    String eventName,
    IList<String> selectedAllergicNames,
  ) async {
    for (var item in selectedAllergicNames) {
      await FirebaseAnalytics.instance
          .logEvent(name: '${eventName}_allergic', parameters: {'allergic': item.toString()});
    }
  }

  void logFoodPreferencesDislikeEvent(
    String eventName,
    IList<String> selectedDislikeNames,
  ) async {
    for (var item in selectedDislikeNames) {
      await FirebaseAnalytics.instance
          .logEvent(name: '${eventName}_dislike', parameters: {'dislike': item.toString()});
    }
  }

  void logLessonCompletedEvent(String eventName, int lessonId) async {
    FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: {
        'lessonId': lessonId,
      },
    );
  }

  void logLessonEvent(String eventName, int lessonId, LessonPage lesson) async {
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: {
        'lessonId': lessonId,
        'lessonType': lesson.type.name,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void leaveLessonEvent(String eventName, int lessonId, String lessonType) async {
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: {
        'lessonId': lessonId,
        'lessonType': lessonType,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void openedTextLessonVersionEvent(int lessonId) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'opened_text_lesson_version',
      parameters: {
        'lessonId': lessonId,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void closedTextLessonVersionEvent(int lessonId) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'closed_text_lesson_version',
      parameters: {
        'lessonId': lessonId,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioPlayEvent(int lessonId) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'lesson_audio_play',
      parameters: {
        'lessonId': lessonId,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioStopEvent(int lessonId) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'lesson_audio_stop',
      parameters: {
        'lessonId': lessonId,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void lessonAudioFinishedEvent(int lessonId) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'lesson_audio_finished',
      parameters: {
        'lessonId': lessonId,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void logProgramAssessmentEvent(String eventName, int score, String assessmentLike) async {
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: {
        'assessmentLevel': score,
        'assessmentLike': assessmentLike,
      },
    );
  }

  void logPhysicalProgramEvent(String eventName, PhysicalProgram program) async {
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: {
        'programId': program.id,
        'programName': program.name,
        'programDuration': program.duration,
        'programDifficulty': program.difficultyName,
      },
    );
  }

  void logPhysicalActivityVideoEvent(
      String eventName, PhysicalProgram program, PhysicalProgramExercise exercise) async {
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: {
        'programId': program.id,
        'programName': program.name,
        'programDuration': program.duration,
        'programDifficulty': program.difficultyName,
        'exercise': exercise.name,
        'exerciseDuration': exercise.duration,
        'exerciseLink': exercise.video ?? '',
      },
    );
  }

  void openedSessionPreparationMaterialsEvent() async {
    await FirebaseAnalytics.instance.logEvent(
      name: "opened_session_preparation_materials",
      parameters: {
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void closedSessionPreparationMaterialsEvent() async {
    await FirebaseAnalytics.instance.logEvent(
      name: "closed_session_preparation_materials",
      parameters: {
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
}
