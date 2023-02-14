import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
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
  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsTypes() async {
    return client
        .get('/food-preferences/types')
        .then(parseResponse(FoodPreferenceResponse.fromJson));
  }

  @override
  Future<Either<RequestError, FoodPreferenceResponse>>
      foodPrefsPeriods() async {
    return client
        .get('/food-preferences/periods')
        .then(parseResponse(FoodPreferenceResponse.fromJson));
  }

  @override
  Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsItems() async {
    return client
        .get('/food-preferences/periods')
        .then(parseResponse(FoodPreferenceResponse.fromJson));
  }

  @override
  Future<Either<RequestError, FoodPreferencesResponse>> foodPrefsFetch() async {
    return client
        .get('/food-preferences')
        .then(parseResponse(FoodPreferencesResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> foodPrefsSave(FoodPrefsData data) async {
    return client
        .post('/food-preferences', data: data)
        .then(parseResponse(FoodPreferenceResponse.fromJson));
  }
}
