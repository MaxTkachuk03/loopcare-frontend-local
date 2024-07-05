import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/calendar_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lesson_content_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/save_lesson_quiz_question_answer_body.dart';
import 'package:loopcare_frontend/features/quizzes/domain/quiz.dart';

abstract class EducationService {
  Future<Either<RequestError, GetLessonsResponse>> getLessons();

  Future<Either<RequestError, GetLessonContentResponse>> getLessonContent(int lessonId);

  Future<Either<RequestError, Quiz>> saveLessonQuizQuestionAnswer(
      int quizId, SaveLessonQuizQuestionAnswerBody data);

  Future<Either<RequestError, GetLessonContentResponse>> completeLesson(int lessonId);

  Future<Either<RequestError, dynamic>> downloadFile(String url, String savePath);

  Future<Either<RequestError, CalendarLessonsResponse>> getCalendarLessons(
      {required String startDate, required String endDate});
}
