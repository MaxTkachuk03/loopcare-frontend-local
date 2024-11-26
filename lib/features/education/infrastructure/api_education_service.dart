import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lesson_content_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/dto/save_lesson_quiz_question_answer_body.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson.dart';
import 'package:loopcare_frontend/features/education/infrastructure/interactive_lesson_mock_new_structure.dart';
import 'package:loopcare_frontend/features/education/infrastructure/commitment_mock.dart';
import 'package:loopcare_frontend/features/education/infrastructure/nutrition_mock.dart';
import 'package:loopcare_frontend/features/education/infrastructure/test_mock.dart';

import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz.dart';

// import 'package:loopcare_frontend/features/education/infrastructure/lesson_mock.dart';
// import 'package:loopcare_frontend/features/education/infrastructure/lessons_mock.dart';

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
  Future<Either<RequestError, InteractiveLesson>> getInteractiveLesson(
      int lessonId) async {
    // TODO: delete after dev phase
    if (lessonId == 6) {
      return right(InteractiveLesson.fromJson(commitmentLesson));
    } else if (lessonId == 7) {
      return right(InteractiveLesson.fromJson(nutritionLesson));
    } else if (lessonId == 5) {
      return right(InteractiveLesson.fromJson(interactiveLesson));
    } else {
      return right(InteractiveLesson.fromJson(testLesson));
    }

    // return client.get(
    //   '/education/intractive-lesson/$lessonId',
    //   fromJson: InteractiveLesson.fromJson,
    // );
  }

  @override
  Future<Either<RequestError, dynamic>> downloadFile(
    String url,
    String savePath,
  ) async {
    return await client.downloading(url, savePath: savePath);
  }
}
