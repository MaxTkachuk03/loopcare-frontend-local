import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/calendar_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lesson_content_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';
import 'package:loopcare_frontend/features/education/domain/questions/lesson_answer_body.dart';
import 'package:loopcare_frontend/features/education/domain/questions/lesson_questions_response.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';

@Injectable(as: EducationService)
class APIEducationService implements EducationService {
  DioClient client;

  APIEducationService(this.client);

  @override
  Future<Either<RequestError, LessonQuestionsResponse>> getAllLessonQuestions(
      String? startDate, String? endDate) {
    final queryParameters = <String, dynamic>{};
    if (startDate != null && endDate != null) {
      queryParameters.addAll({
        'startDate': startDate,
        'endDate': endDate,
      });
    }

    return client
        .get('/education/lesson-questions', queryParameters: queryParameters)
        .then(parseResponse(LessonQuestionsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, LessonQuestion>> getLessonQuestions(int lessonQuestionId) {
    return client
        .get('/education/lesson-questions/$lessonQuestionId')
        .then(parseResponse(LessonQuestion.fromJson));
  }

  @override
  Future<Either<RequestError, LessonQuestion>> saveLessonAnswerText(
    int lessonQuestionId,
    LessonAnswerTextBody data,
  ) async {
    return client
        .post('/education/lesson-questions/$lessonQuestionId/submit', data: data)
        .then(parseResponse(LessonQuestion.fromJson));
  }

  @override
  Future<Either<RequestError, LessonQuestion>> saveLessonAnswerOption(
    int lessonQuestionId,
    LessonAnswerOptionBody data,
  ) async {
    return client
        .post('/education/lesson-questions/$lessonQuestionId/submit', data: data)
        .then(parseResponse(LessonQuestion.fromJson));
  }

  @override
  Future<Either<RequestError, LessonQuestion>> updateLessonAnswerText(
    int lessonQuestionId,
    LessonAnswerTextBody data,
  ) async {
    return client
        .patch('/education/lesson-questions/$lessonQuestionId/submit', data: data)
        .then(parseResponse(LessonQuestion.fromJson));
  }

  @override
  Future<Either<RequestError, LessonQuestion>> updateLessonAnswerOption(
    int lessonQuestionId,
    LessonAnswerOptionBody data,
  ) async {
    return client
        .patch('/education/lesson-questions/$lessonQuestionId/submit', data: data)
        .then(parseResponse(LessonQuestion.fromJson));
  }

  @override
  Future<Either<RequestError, GetLessonsResponse>> getLessons(
    LessonCategory category,
  ) async {
    final params = category == LessonCategory.all ? null : {'category': category.name};
    return client
        .get('/education/lessons', queryParameters: params)
        .then(parseResponse(GetLessonsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, GetLessonContentResponse>> getLessonContent(
    int lessonId,
  ) async {
    return client.get('/education/lessons/$lessonId').then(parseResponse(GetLessonContentResponse.fromJson));
  }

  @override
  Future<Either<RequestError, GetLessonContentResponse>> completeLesson(
    int lessonId,
  ) {
    return client.post(
      '/education/lessons/$lessonId/complete',
      data: {"completedAt": DateTime.now().toUtc().toIso8601String()},
    ).then(parseResponse(GetLessonContentResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> downloadFile(
    String url,
    String savePath,
  ) async {
    return client.downloading(
      url,
      savePath,
    );
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

    return client
        .get('/education/lessons/calendar', queryParameters: queryParameters)
        .then(parseResponse(CalendarLessonsResponse.fromJson));
  }
}
