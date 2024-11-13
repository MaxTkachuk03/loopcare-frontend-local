import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/account/infrastructure/food_preference/dto/food_preference_response.dart';
import 'package:loopcare_frontend/features/account/infrastructure/food_preference/dto/food_preferences_response.dart';
import 'package:loopcare_frontend/features/account/infrastructure/food_preference/dto/food_prefs_data.dart';

abstract class FoodPreferenceService {
  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsHates();

  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsPeriods();

  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsAllergens();

  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsDislikes();

  Future<Either<RequestError, FoodPreferencesResponse>> foodPrefsFetch();

  Future<Either<RequestError, dynamic>> foodPrefsSave(FoodPrefsData data);
}
