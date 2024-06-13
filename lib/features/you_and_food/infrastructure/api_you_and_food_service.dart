import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference_response.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preferences_response.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_prefs_data.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_service.dart';

@Injectable(as: YouAndFoodService)
class APIYouAndFoodService implements YouAndFoodService {
  DioClient client;

  APIYouAndFoodService(this.client);

  @override
  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsHates() async {
    return await client.get(
      '/food-preferences/hates',
      fromJson: FoodPreferenceResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsPeriods() async {
    return await client.get(
      '/food-preferences/periods',
      fromJson: FoodPreferenceResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsAllergens() async {
    return await client.get(
      '/food-preferences/allergens',
      fromJson: FoodPreferenceResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsDislikes() async {
    return await client.get(
      '/food-preferences/dislikes',
      fromJson: FoodPreferenceResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, FoodPreferencesResponse>> foodPrefsFetch() async {
    return await client.get(
      '/food-preferences',
      fromJson: FoodPreferencesResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, dynamic>> foodPrefsSave(FoodPrefsData data) async {
    return await client.post('/food-preferences', data: data);
  }
}
