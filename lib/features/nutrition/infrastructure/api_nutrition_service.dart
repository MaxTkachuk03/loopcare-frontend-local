import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/dto/values_explanation_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/add_to_favorites_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/add_to_favorites_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_servings_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/update_favorite_body.dart';

@Injectable(as: NutritionService)
class APINutritionService implements NutritionService {
  DioClient client;

  APINutritionService(this.client);

  @override
  Future<Either<RequestError, ValuesExplanationResponse>>
      getValuesExplanation() async {
    return client
        .get('/nutrition/value-explanation')
        .then(parseResponse(ValuesExplanationResponse.fromJson));
  }

  @override
  Future<Either<RequestError, FoodItemServingsResponse>> getFoodItemServings(
      String id) async {
    return client
        .get('/food-items/$id/servings')
        .then(parseResponse(FoodItemServingsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, AddToFavoritesResponse>> addToFavorites(
    String foodItemId,
    AddToFavoritesBody data,
  ) {
    return client
        .post('/food-items/$foodItemId/favorites', data: data)
        .then(parseResponse(AddToFavoritesResponse.fromJson));
  }

  @override
  Future<Either<RequestError, AddToFavoritesResponse>> removeFromFavorites(
    String foodItemId,
    String? servingId,
  ) {
    return client
        .delete('/food-items/$foodItemId/favorites/$servingId')
        .then(parseResponse(AddToFavoritesResponse.fromJson));
  }

  @override
  Future<Either<RequestError, AddToFavoritesResponse>> updateFavorites(
    String foodItemId,
    String? servingId,
    UpdateFavoriteBody data,
  ) {
    return client
        .patch('/food-items/$foodItemId/favorites/$servingId', data: data)
        .then(parseResponse(AddToFavoritesResponse.fromJson));
  }
}
