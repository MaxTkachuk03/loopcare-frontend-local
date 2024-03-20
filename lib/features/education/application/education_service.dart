import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/calendar_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lesson_content_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lessons_response.dart';
import 'package:loopcare_frontend/features/education/domain/questions/lesson_answer_body.dart';
import 'package:loopcare_frontend/features/education/domain/questions/lesson_questions_response.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';

abstract class EducationService {
  Future<Either<RequestError, LessonQuestionsResponse>> getAllLessonQuestions(
    String? startDate,
    String? endDate,
  );

  Future<Either<RequestError, LessonQuestion>> getLessonQuestions(
    int lessonQuestionId,
  );

  Future<Either<RequestError, LessonQuestion>> saveLessonAnswerText(
    int lessonQuestionId,
    LessonAnswerTextBody data,
  );

  Future<Either<RequestError, LessonQuestion>> saveLessonAnswerOption(
    int lessonQuestionId,
    LessonAnswerOptionBody data,
  );

  Future<Either<RequestError, LessonQuestion>> updateLessonAnswerText(
    int lessonQuestionId,
    LessonAnswerTextBody data,
  );

  Future<Either<RequestError, LessonQuestion>> updateLessonAnswerOption(
    int lessonQuestionId,
    LessonAnswerOptionBody data,
  );

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
