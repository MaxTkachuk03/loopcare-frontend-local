import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/get_nutrition_intake_response.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/nutrition_intake_complete_day/nutrition_intake_complete_day.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/nutrition_intake_finfish_lessons/nutrition_intake_finish_lessons.dart';

abstract interface class NutritionIntakeServices {
  Future<Either<RequestError, GetNutritionIntakeResponse>> getLessons({required DateTime date});

  Future<Either<RequestError, NutritionIntakeCompleteDay>> completeDay({required DateTime date});

  Future<Either<RequestError, NutritionIntakeFinishLessons>> finishLesson(
      {required DateTime date, required int iLessonId});
}
