import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/dto/barcode_information_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_many_food_items_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/dto/favorites_response.dart';
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

  Future<Either<RequestError, MealsResponse>> getMeals();

  Future<Either<RequestError, MealsListItem>> addMeal(
    AddMealBody data,
  );

  Future<Either<RequestError, MealsListItem>> getMealById(
    String mealId,
  );

  Future<Either<RequestError, MealsListItem>> removeMeal(
    String mealId,
  );

  Future<Either<RequestError, MealsResponse>> addFoodItemToMeal(
    String mealId,
    String foodItemId,
    AddFoodItemToMealBody data,
  );

  Future<Either<RequestError, MealsResponse>> addManyFoodItemsToMeal(
    String mealId,
    AddManyFoodItemsToMealBody data,
  );

  Future<Either<RequestError, MealsListItem>> updateFoodItemInMeal(
    String mealId,
    String foodItemId,
    AddFoodItemToMealBody data,
  );

  Future<Either<RequestError, MealsListItem>> removeFoodItemFromMeal(
    String mealId,
    String foodItemId,
  );
}
