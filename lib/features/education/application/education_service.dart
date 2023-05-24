import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lessons_response.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';

abstract class EducationService {
  Future<Either<RequestError, GetLessonsResponse>> getLessons(
      LessonCategory category);
}
