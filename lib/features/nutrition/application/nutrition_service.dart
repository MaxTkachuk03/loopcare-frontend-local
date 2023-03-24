import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/dto/favorites_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/barcode_scanner/barcode_information_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/dto/values_explanation_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/add_to_favorites_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/add_to_favorites_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_servings_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/update_favorite_body.dart';

abstract class NutritionService {
  Future<Either<RequestError, ValuesExplanationResponse>>
      getValuesExplanation();

  Future<Either<RequestError, FavoritesResponse>> getFavorites();

  Future<Either<RequestError, FavoritesResponse>> getFilteredFavorites(
      List<String> mealCategories);

  Future<Either<RequestError, FoodItemServingsResponse>> getFoodItemServings(
    String id,
  );

  Future<Either<RequestError, AddToFavoritesResponse>> addToFavorites(
    String foodItemId,
    AddToFavoritesBody data,
  );

  Future<Either<RequestError, AddToFavoritesResponse>> removeFromFavorites(
    String foodItemId,
    String? servingId,
  );

  Future<Either<RequestError, AddToFavoritesResponse>> updateFavorites(
    String foodItemId,
    String? servingId,
    UpdateFavoriteBody data,
  );

  Future<Either<RequestError, BarcodeInformationResponse>>
      getBarcodeInformation(
    String barCode,
  );
}
