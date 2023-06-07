import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/get_dashboard_weights_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/log_weight_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/log_weight_response.dart';

import 'package:loopcare_frontend/features/nutrition/application/dish/dto/add_dish_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/add_food_item_to_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/clone_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_dish_food_item_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_food_item_in_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_planned_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/create_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/create_dish_from_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/create_dish_from_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/update_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_food_item_to_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_recipe_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/recipe_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/update_food_item_in_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/update_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/dto/recipe_details_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/dto/favorites_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/dto/barcode_information_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_many_food_items_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/dto/values_explanation_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/dto/get_dishes_response.dart';
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
  Future<Either<RequestError, FavoritesResponse>> getFavorites(
    List<String>? mealCategories,
  ) async {
    return client.get('/food-items/favorites', queryParameters: {
      "mealCategories": mealCategories ?? [],
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
  Future<Either<RequestError, RecipeDetailsResponse>> getRecipe(int id) {
    return client
        .get('/recipes/$id')
        .then(parseResponse(RecipeDetailsResponse.fromJson));
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
  Future<Either<RequestError, MealsListItem>> addRecipeToMeal({
    required int mealId,
    required int recipeId,
    required AddRecipeToMealBody data,
  }) {
    return client
        .post('/meals/$mealId/recipes/$recipeId', data: data)
        .then(parseResponse(MealsListItem.fromJson));
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
  Future<Either<RequestError, RecipeResponse>> updateFoodItemInRecipeInMeal({
    required int mealId,
    required int recipeId,
    required String foodItemId,
    required UpdateFoodItemInRecipeBody data,
  }) {
    return client
        .patch(
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
  Future<Either<RequestError, MealsListItem>> deleteDishFromMeal(
    int mealId,
    String dishId,
  ) {
    return client
        .delete('/meals/$mealId/dishes/$dishId')
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsResponse>> getMeals({
    String? startDate,
    String? endDate,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (startDate != null && endDate != null) {
      queryParameters.addAll({
        'startDate': startDate,
        'endDate': endDate,
      });
    }
    return client
        .get('/meals', queryParameters: queryParameters)
        .then(parseResponse(MealsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, MealsResponse>> getPlannedMeals({
    String? startDate,
    String? endDate,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (startDate != null && endDate != null) {
      queryParameters.addAll({
        'startDate': startDate,
        'endDate': endDate,
      });
    }
    return client
        .get('/planned-meals', queryParameters: queryParameters)
        .then(parseResponse(MealsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> addMeal(AddMealBody data) {
    return client
        .post('/meals', data: data)
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> addPlannedMeal(
      AddPlannedMealBody data) {
    return client
        .post('/planned-meals', data: data)
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> getMealById(int mealId) async {
    return client
        .get('/meals/$mealId')
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> getPlannedMealById(
      int mealId) async {
    return client
        .get('/planned-meals/$mealId')
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> removeMeal(int mealId) {
    return client
        .delete('/meals/$mealId')
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> removePlannedMeal(int mealId) {
    return client
        .delete('/planned-meals/$mealId')
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> addFoodItemToMeal(
    int mealId,
    String foodItemId,
    AddFoodItemToMealBody data,
  ) {
    return client
        .post('/meals/$mealId/food-items/$foodItemId', data: data)
        .then(parseResponse(MealsListItem.fromJson));
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

  @override
  Future<Either<RequestError, SearchResponse>> search(
    String query, {
    List<String>? mode,
    int? limit,
  }) {
    return client.get(
      '/nutrition/search',
      queryParameters: {
        'query': query,
        if (mode != null && mode.isNotEmpty) 'modes': mode,
        if (limit != null) 'limit': limit,
        // TODO: Remove after pagination will be implemented on backend
        if (limit == null) 'limit': 20,
      },
    ).then(parseResponse(SearchResponse.fromJson));
  }

  @override
  Future<Either<RequestError, GetDashboardWeightsResponse>> getDashboardWeights(
    String startDate,
    String endDate,
  ) {
    return client.get(
      '/weight/logs',
      queryParameters: {"startDate": startDate, "endDate": endDate},
    ).then(parseResponse(GetDashboardWeightsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, LogWeightResponse>> logWeight(
    LogWeightBody data,
  ) {
    return client
        .post('/weight/log', data: data)
        .then(parseResponse(LogWeightResponse.fromJson));
  }

  @override
  Future<Either<RequestError, GetDishesResponse>> getDishes(
    List<String>? mealCategories,
  ) {
    return client.get(
      '/dishes',
      queryParameters: {"mealCategories": mealCategories ?? []},
    ).then(parseResponse(GetDishesResponse.fromJson));
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> getDishById(
    int id,
  ) {
    return client
        .get('/dishes/$id')
        .then(parseResponse(UpdateDishFoodItemResponse.fromJson));
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> createDishFromRecipe(
    CreateDishFromRecipeBody data,
  ) {
    return client
        .post('/dishes/recipes', data: data)
        .then(parseResponse(UpdateDishFoodItemResponse.fromJson));
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> createDishFromMeal(
    CreateDishFromMealBody data,
  ) {
    return client
        .post('/dishes/meals', data: data)
        .then(parseResponse(UpdateDishFoodItemResponse.fromJson));
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> createDish(
    CreateDishBody data,
  ) {
    return client
        .post('/dishes', data: data)
        .then(parseResponse(UpdateDishFoodItemResponse.fromJson));
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> updateDishById(
    int id,
    UpdateDishBody data,
  ) {
    return client
        .patch('/dishes/$id', data: data)
        .then(parseResponse(UpdateDishFoodItemResponse.fromJson));
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> updateFoodItemInDish(
    int dishId,
    String internalFoodItemId,
    UpdateFoodItemInDishBody data,
  ) {
    return client
        .patch('/dishes/$dishId/food-items/$internalFoodItemId', data: data)
        .then(parseResponse(UpdateDishFoodItemResponse.fromJson));
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>>
      deleteFoodItemFromDish(
    int dishId,
    int internalFoodItemId,
  ) {
    return client
        .delete('/dishes/$dishId/food-items/$internalFoodItemId')
        .then(parseResponse(UpdateDishFoodItemResponse.fromJson));
  }

  @override
  Future<Either<RequestError, MealsListItem>> addDishToMeal(
    int mealId,
    AddDishToMealBody data,
  ) {
    return client
        .post('/meals/$mealId/dishes', data: data)
        .then(parseResponse(MealsListItem.fromJson));
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> cloneDish(
    CloneDishBody data,
  ) {
    return client
        .post('/dishes/clone', data: data)
        .then(parseResponse(UpdateDishFoodItemResponse.fromJson));
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> deleteDish(
    int dishId,
  ) {
    return client
        .delete('/dishes/$dishId')
        .then(parseResponse(UpdateDishFoodItemResponse.fromJson));
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> addFoodItemToDish(
    int dishId,
    AddFoodItemToDishBody data,
  ) {
    return client
        .post('/dishes/$dishId/food-item', data: data)
        .then(parseResponse(UpdateDishFoodItemResponse.fromJson));
  }
}
