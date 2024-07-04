import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/calendar_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lesson_content_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/save_lesson_quiz_question_answer_body.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/quizzes/domain/quiz.dart';
// import 'package:loopcare_frontend/features/education/infrastructure/lesson_mock.dart';
// import 'package:loopcare_frontend/features/education/infrastructure/lessons_mock.dart';

@Injectable(as: EducationService)
class APIEducationService implements EducationService {
  DioClient client;

  APIEducationService(this.client);
  //
  // @override
  // Future<Either<RequestError, LessonQuestionsResponse>> getAllLessonQuestions(
  //   String? startDate,
  //   String? endDate,
  // ) async {
  //   final queryParameters = <String, dynamic>{};
  //   if (startDate != null && endDate != null) {
  //     queryParameters.addAll({
  //       'startDate': startDate,
  //       'endDate': endDate,
  //     });
  //   }
  //
  //   return await client.get(
  //     '/education/lesson-questions',
  //     queryParameters: queryParameters,
  //     fromJson: LessonQuestionsResponse.fromJson,
  //   );
  // }

  // @override
  // Future<Either<RequestError, dynamic>> getLessonQuestions(int lessonQuestionId) async {
  //   return await client.get(
  //     '/education/lesson-questions/$lessonQuestionId',
  //     fromJson: LessonQuestion.fromJson,
  //   );
  // }
  //
  // @override
  // Future<Either<RequestError, dynamic>> saveLessonAnswerText(
  //   int lessonQuestionId,
  //   LessonAnswerTextBody data,
  // ) async {
  //   return await client.post(
  //     '/education/lesson-questions/$lessonQuestionId/submit',
  //     data: data,
  //     fromJson: LessonQuestion.fromJson,
  //   );
  // }
  //
  // @override
  // Future<Either<RequestError, dynamic>> saveLessonAnswerOption(
  //   int lessonQuestionId,
  //   LessonAnswerOptionBody data,
  // ) async {
  //   return await client.post(
  //     '/education/lesson-questions/$lessonQuestionId/submit',
  //     data: data,
  //     fromJson: LessonQuestion.fromJson,
  //   );
  // }
  //
  // @override
  // Future<Either<RequestError, dynamic>> updateLessonAnswerText(
  //   int lessonQuestionId,
  //   LessonAnswerTextBody data,
  // ) async {
  //   return await client.patch(
  //     '/education/lesson-questions/$lessonQuestionId/submit',
  //     data: data,
  //     fromJson: LessonQuestion.fromJson,
  //   );
  // }
  //
  // @override
  // Future<Either<RequestError, dynamic>> updateLessonAnswerOption(
  //   int lessonQuestionId,
  //   LessonAnswerOptionBody data,
  // ) async {
  //   return await client.patch(
  //     '/education/lesson-questions/$lessonQuestionId/submit',
  //     data: data,
  //     fromJson: LessonQuestion.fromJson,
  //   );
  // }

  @override
  Future<Either<RequestError, GetLessonsResponse>> getLessons() async {
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
  Future<Either<RequestError, GetLessonContentResponse>> completeLesson(
    int lessonId,
  ) async {
    return await client.post(
      '/education/lessons/$lessonId/complete',
      data: {"completedAt": DateTime.now().toUtc().toIso8601String()},
      fromJson: GetLessonContentResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, dynamic>> downloadFile(
    String url,
    String savePath,
  ) async {
    return await client.downloading(url, savePath: savePath);
  }

  @override
  Future<Either<RequestError, CalendarLessonsResponse>> getCalendarLessons({
    required String startDate,
    required String endDate,
  }) async {
    final queryParameters = {
      'startDate': startDate,
      'endDate': endDate,
    };

    return await client.get(
      '/education/lessons/calendar',
      queryParameters: queryParameters,
      fromJson: CalendarLessonsResponse.fromJson,
    );
  }
}
