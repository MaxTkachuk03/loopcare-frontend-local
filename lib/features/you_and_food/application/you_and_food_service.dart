import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference_response.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preferences_response.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_prefs_data.dart';

abstract class YouAndFoodService {
  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsTypes();

  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsPeriods();

  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsItems();

  Future<Either<RequestError, FoodPreferencesResponse>> foodPrefsFetch();

  Future<Either<RequestError, dynamic>> foodPrefsSave(FoodPrefsData data);
}
