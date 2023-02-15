import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_types_response.dart';

abstract class DiabetesService {
  Future<Either<RequestError, DiabetesTypesResponse>> diabetesTypes();

  // Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsPeriods();
  //
  // Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsItems();
  //
  // Future<Either<RequestError, dynamic>> foodPrefsSave(FoodPrefsData data);
}
