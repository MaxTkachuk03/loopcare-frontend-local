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

@Injectable(as: EducationService)
class APIEducationService implements EducationService {
  DioClient client;

  APIEducationService(this.client);

  @override
  Future<Either<RequestError, GetLessonsResponse>> getLessons(
    LessonCategory category,
  ) async {
    final params =
        category == LessonCategory.all ? null : {'category': category.name};

    return client
        .get('/education/lessons', queryParameters: params)
        .then(parseResponse(GetLessonsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, GetLessonContentResponse>> getLessonContent(
    int lessonId,
  ) async {
    return client
        .get('/education/lessons/$lessonId')
        .then(parseResponse(GetLessonContentResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> completeLesson(int lessonId) {
    return client.post(
      '/education/lessons/$lessonId/complete',
      data: {"completedAt": DateTime.now().toUtc().toIso8601String()},
    ).then(parseResponse(GetLessonsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, CalendarLessonsResponse>> getCalendarLessons({
    String? startDate,
    String? endDate,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (startDate != null && endDate != null) {
      queryParameters.addAll({
        'startDate': startDate,
        'endDate': endDate,
      });
    }

    return client
        .get('/education/lessons/calendar', queryParameters: queryParameters)
        .then(parseResponse(CalendarLessonsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> downloadFile(String url) {
    return client.get(url);
  }
}
