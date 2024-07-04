import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/calendar_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lesson_content_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lessons_response.dart';
import 'package:loopcare_frontend/features/education/domain/questions/lesson_answer_body.dart';

abstract class EducationService {
  // Future<Either<RequestError, LessonQuestionsResponse>> getAllLessonQuestions(
  //   String? startDate,
  //   String? endDate,
  // );

  // Future<Either<RequestError, dynamic>> getLessonQuestions(
  //   int lessonQuestionId,
  // );
  //
  // Future<Either<RequestError, dynamic>> saveLessonAnswerText(
  //   int lessonQuestionId,
  //   LessonAnswerTextBody data,
  // );
  //
  // Future<Either<RequestError, dynamic>> saveLessonAnswerOption(
  //   int lessonQuestionId,
  //   LessonAnswerOptionBody data,
  // );
  //
  // Future<Either<RequestError, dynamic>> updateLessonAnswerText(
  //   int lessonQuestionId,
  //   LessonAnswerTextBody data,
  // );
  //
  // Future<Either<RequestError, dynamic>> updateLessonAnswerOption(
  //   int lessonQuestionId,
  //   LessonAnswerOptionBody data,
  // );

  Future<Either<RequestError, GetLessonsResponse>> getLessons();

  Future<Either<RequestError, GetLessonContentResponse>> getLessonContent(
    int lessonId,
  );

  Future<Either<RequestError, GetLessonContentResponse>> completeLesson(
    int lessonId,
  );

  Future<Either<RequestError, dynamic>> downloadFile(
    String url,
    String savePath,
  );

  Future<Either<RequestError, CalendarLessonsResponse>> getCalendarLessons({
    required String startDate,
    required String endDate,
  });
}
