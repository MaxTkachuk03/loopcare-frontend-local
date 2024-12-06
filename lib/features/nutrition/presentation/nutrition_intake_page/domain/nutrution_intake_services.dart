import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/get_nutrition_intake_response.dart';

abstract interface class NutrutionIntakeServices {
  Future<Either<RequestError, GetNutritionIntakeResponse>> getLessons(
      {required DateTime date});

  Future<Either<RequestError, GetNutritionIntakeResponse>> closeDay(
      {required bool isDayClosed});
}
