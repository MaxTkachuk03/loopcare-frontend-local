import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/dto/values_explanation_response.dart';

abstract class NutritionService {
  Future<Either<RequestError, ValuesExplanationResponse>>
      getValuesExplanation();
}
