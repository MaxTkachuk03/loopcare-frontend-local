import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lesson_content_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/save_lesson_quiz_question_answer_body.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz.dart';
import 'package:loopcare_frontend/features/education/application/dto/save_interactive_lesson_progress_body.dart';
import 'package:loopcare_frontend/features/education/application/dto/interactive_lesson_progress_response.dart';

abstract class EducationService {
  Future<Either<RequestError, GetLessonsResponse>> getLessons();

  Future<Either<RequestError, GetLessonContentResponse>> getLessonContent(int lessonId);

  Future<Either<RequestError, Quiz>> saveLessonQuizQuestionAnswer(
    int quizId,
    SaveLessonQuizQuestionAnswerBody data,
  );

  Future<Either<RequestError, InteractiveLesson>> getInteractiveLesson(int lessonId, String? date);

  Future<Either<RequestError, InteractiveLessonProgressResponse>> saveInteractiveLessonProgress(
      int chunkId, SaveInteractiveLessonProgressBody data);

  Future<Either<RequestError, dynamic>> downloadFile(String url, String savePath);
}
