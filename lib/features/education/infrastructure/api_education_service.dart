import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lesson_content_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/interactive_lesson_progress_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/save_lesson_quiz_question_answer_body.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/features/education/application/dto/save_interactive_lesson_progress_body.dart';

@Injectable(as: EducationService)
class APIEducationService implements EducationService {
  DioClient client;

  APIEducationService(this.client);

  @override
  Future<Either<RequestError, GetLessonsResponse>> getLessons() async {
    // TODO method will be back in the another format
    // TODO mock
    // return right(GetLessonsResponse.fromJson({'lessons': lessons}));
    return await client.get(
      '/education/lessons',
      fromJson: GetLessonsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, GetLessonContentResponse>> getLessonContent(
    int lessonId,
  ) async {
    // TODO mock
    // return right(GetLessonContentResponse.fromJson(lesson));
    return await client.get(
      '/education/lessons/$lessonId',
      fromJson: GetLessonContentResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, Quiz>> saveLessonQuizQuestionAnswer(
    int quizId,
    SaveLessonQuizQuestionAnswerBody data,
  ) async {
    return await client.post(
      '/education/lesson-quiz/$quizId/submit',
      data: data,
      fromJson: Quiz.fromJson,
    );
  }

  @override
  Future<Either<RequestError, InteractiveLesson>> getInteractiveLesson(int lessonId, DateTime? date) async {
    // TODO: delete after dev phase
    // if (lessonId == 6) {
    //   return right(InteractiveLesson.debugFromJson(commitmentLesson));
    // } else if (lessonId == 7) {
    //   return right(InteractiveLesson.debugFromJson(nutritionLesson));
    // } else if (lessonId == 5) {
    //   return right(InteractiveLesson.debugFromJson(interactiveLesson));
    // } else if (lessonId == 1) {
    //   return right(InteractiveLesson.debugFromJson(nutritionIntakeLesson));
    // } else if (lessonId == 2) {
    //   return right(InteractiveLesson.debugFromJson(nutritionIntakeLessonSnaks));
    // } else {
    //   return right(InteractiveLesson.debugFromJson(testLesson));
    // }

    // return client.get(
    //   '/education/interactive-lessons/$lessonId',
    //   fromJson: InteractiveLesson.fromJson,
    // );

    try {
      final response = await client.get(
        '/education/interactive-lessons/$lessonId',
        queryParameters: {"date": date},
        fromJson: InteractiveLesson.debugFromJson,
      );
      log.d('Raw Response: response');
      return response;
    } catch (e, stackTrace) {
      log.w('Error in client.get: $e');
      log.w('Stack Trace: $stackTrace');
      rethrow; // Optional: rethrow the error for further handling
    }
  }

  @override
  Future<Either<RequestError, InteractiveLessonProgressResponse>> saveInteractiveLessonProgress(
    int chunkId,
    SaveInteractiveLessonProgressBody data,
  ) async {
    return await client.post(
      '/education/interactive-lessons/progress/$chunkId',
      data: data,
      fromJson: InteractiveLessonProgressResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, dynamic>> downloadFile(
    String url,
    String savePath,
  ) async {
    return await client.downloading(url, savePath: savePath);
  }
}
