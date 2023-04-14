import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_food_item_to_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_recipe_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/recipe_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/update_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/dto/favorites_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/dto/barcode_information_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_many_food_items_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_response.dart';
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
  Future<Either<RequestError, FavoritesResponse>> getFavorites() async {
    return client
        .get('/food-items/favorites')
        .then(parseResponse(FavoritesResponse.fromJson));
  }

  @override
  Future<Either<RequestError, FavoritesResponse>> getFilteredFavorites(
    List<String> mealCategories,
  ) async {
    return client.get('/food-items/favorites', queryParameters: {
      "mealCategories": mealCategories,
    }).then(parseResponse(FavoritesResponse.fromJson));
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
    String servingId,
    AddToFavoritesBody data,
  ) {
    return client
        .post('/food-items/$foodItemId/favorites/$servingId', data: data)
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

  @override
  Future<Either<RequestError, BarcodeInformationResponse>>
      getBarcodeInformation(String barCode) {
    return client
        .get('/food-items/barcode/$barCode')
        .then(parseResponse(BarcodeInformationResponse.fromJson));
  }

  @override
  Future<Either<RequestError, RecipeResponse>> getRecipe(int id) {
    return client
        .get('/recipes/$id')
        .then(parseResponse(RecipeResponse.fromJson));
  }

  @override
  Future<Either<RequestError, RecipeResponse>> getRecipeInMeal(
    int mealId,
    int recipeId,
  ) {
    return client
        .get('/meals/$mealId/recipes/$recipeId')
        .then(parseResponse(RecipeResponse.fromJson));
  }

  @override
  Future<Either<RequestError, RecipeResponse>> addRecipeToMeal({
    required int mealId,
    required int recipeId,
    required AddRecipeToMealBody data,
  }) {
    return client
        .post('/meals/$mealId/recipes/$recipeId', data: data)
        .then(parseResponse(RecipeResponse.fromJson));
  }

  @override
  Future<Either<RequestError, RecipeResponse>> addFoodItemToRecipeInMeal({
    required int mealId,
    required int recipeId,
    required String foodItemId,
    required AddFoodItemToRecipeBody data,
  }) {
    return client
        .post(
          '/meals/$mealId/recipes/$recipeId/food-items/$foodItemId',
          data: data,
        )
        .then(parseResponse(RecipeResponse.fromJson));
  }

  @override
  Future<Either<RequestError, RecipeResponse>> removeFoodItemFromRecipeInMeal({
    required int mealId,
    required int recipeId,
    required String foodItemId,
  }) {
    return client
        .delete('/meals/$mealId/recipes/$recipeId/food-items/$foodItemId')
        .then(parseResponse(RecipeResponse.fromJson));
  }

  @override
  Future<Either<RequestError, RecipeResponse>> updateRecipeNumberOfServing({
    required int mealId,
    required int recipeId,
    required UpdateRecipeBody data,
  }) {
    return client
        .patch('/meals/$mealId/recipes/$recipeId', data: data)
        .then(parseResponse(RecipeResponse.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> deleteRecipeFromMeal(
    int mealId,
    String recipeId,
  ) {
    return client
        .delete('/meals/$mealId/recipes/$recipeId')
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsResponse>> getMeals() async {
    return client.get('/meals').then(parseResponse(MealsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> addMeal(AddMealBody data) {
    return client
        .post('/meals', data: data)
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> getMealById(int mealId) async {
    return client
        .get('/meals/$mealId')
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> removeMeal(int mealId) {
    return client
        .delete('/meals/$mealId')
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsResponse>> addFoodItemToMeal(
    int mealId,
    int foodItemId,
    AddFoodItemToMealBody data,
  ) {
    return client
        .post('/meals/$mealId/food-items/$foodItemId', data: data)
        .then(parseResponse(MealsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> addManyFoodItemsToMeal(
    int mealId,
    AddManyFoodItemsToMealBody data,
  ) {
    return client
        .post('/meals/$mealId/food-items', data: data)
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> updateFoodItemInMeal(
    int mealId,
    int foodItemId,
    AddFoodItemToMealBody data,
  ) {
    return client
        .patch('/meals/$mealId/food-items/$foodItemId', data: data)
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> removeFoodItemFromMeal(
    int mealId,
    String foodItemId,
  ) {
    return client
        .delete('/meals/$mealId/food-items/$foodItemId')
        .then(parseResponse(MealsListItem.fromJson));
  }
}
