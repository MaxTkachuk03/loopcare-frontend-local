import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/dto/barcode_information_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/bmr/dto/get_bmr_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/get_dashboard_weights_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/log_weight_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/log_weight_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/add_dish_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/add_food_item_to_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/clone_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_dish_food_item_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_dish_in_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_food_item_in_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/create_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/create_dish_from_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/create_dish_from_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/update_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_many_food_items_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_planned_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/log_planned_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/update_planned_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_food_item_to_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_recipe_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/recipe_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/update_food_item_in_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/update_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/dto/recipe_details_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/recommendations/dto/recommendations_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/dto/favorites_response.dart';
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
  Future<Either<RequestError, GetBmrResponse>> getBmr(DateTime date) async {
    return await client.get(
      '/nutrition/bmr',
      queryParameters: {"date": date},
      fromJson: GetBmrResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, FavoritesResponse>> getFavorites(
    List<String>? mealCategories,
  ) async {
    return await client.get(
      '/food-items/favorites',
      queryParameters: {
        "mealCategories": mealCategories ?? [],
      },
      fromJson: FavoritesResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, FoodItemServingsResponse>> getFoodItemServings(String id) async {
    return await client.get(
      '/food-items/$id/servings',
      fromJson: FoodItemServingsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, AddToFavoritesResponse>> addToFavorites(
    String foodItemId,
    String servingId,
    AddToFavoritesBody data,
  ) async {
    return await client.post(
      '/food-items/$foodItemId/favorites/$servingId',
      data: data,
      fromJson: AddToFavoritesResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, AddToFavoritesResponse>> removeFromFavorites(
    String foodItemId,
    String? servingId,
  ) async {
    return await client.delete(
      '/food-items/$foodItemId/favorites/$servingId',
      fromJson: AddToFavoritesResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, AddToFavoritesResponse>> updateFavorites(
    String foodItemId,
    String? servingId,
    UpdateFavoriteBody data,
  ) async {
    return await client.patch(
      '/food-items/$foodItemId/favorites/$servingId',
      data: data,
      fromJson: AddToFavoritesResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, BarcodeInformationResponse>> getBarcodeInformation(String barCode) async {
    return await client.get(
      '/food-items/barcode/$barCode',
      fromJson: BarcodeInformationResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, RecipeDetailsResponse>> getRecipe(int id) async {
    return await client.get(
      '/recipes/$id',
      fromJson: RecipeDetailsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, RecommendationsResponse>> getRecommendations(List<String>? mealCategories) async {
    return await client.get(
      '/recipes/recommendations',
      queryParameters: {
        "mealCategories": mealCategories ?? [],
        "pageSize": "20",
      },
      fromJson: RecommendationsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, RecipeResponse>> getRecipeInMeal(
    int mealId,
    int recipeId,
  ) async {
    return await client.get(
      '/meals/$mealId/recipes/$recipeId',
      fromJson: RecipeResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> addRecipeToMeal({
    required int mealId,
    required int recipeId,
    required AddRecipeToMealBody data,
  }) async {
    return await client.post(
      '/meals/$mealId/recipes/$recipeId',
      data: data,
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, RecipeResponse>> addFoodItemToRecipeInMeal({
    required int mealId,
    required int recipeId,
    required String foodItemId,
    required AddFoodItemToRecipeBody data,
  }) async {
    return await client.post(
      '/meals/$mealId/recipes/$recipeId/food-items/$foodItemId',
      data: data,
      fromJson: RecipeResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, RecipeResponse>> updateFoodItemInRecipeInMeal({
    required int mealId,
    required int recipeId,
    required String foodItemId,
    required UpdateFoodItemInRecipeBody data,
  }) async {
    return await client.patch(
      '/meals/$mealId/recipes/$recipeId/food-items/$foodItemId',
      data: data,
      fromJson: RecipeResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, RecipeResponse>> removeFoodItemFromRecipeInMeal({
    required int mealId,
    required int recipeId,
    required String foodItemId,
  }) async {
    return await client.delete(
      '/meals/$mealId/recipes/$recipeId/food-items/$foodItemId',
      fromJson: RecipeResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, RecipeResponse>> updateRecipeNumberOfServing({
    required int mealId,
    required int recipeId,
    required UpdateRecipeBody data,
  }) async {
    return await client.patch(
      '/meals/$mealId/recipes/$recipeId',
      data: data,
      fromJson: RecipeResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> deleteRecipeFromMeal(
    int mealId,
    String recipeId,
  ) async {
    return await client.delete(
      '/meals/$mealId/recipes/$recipeId',
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> deleteDishFromMeal(
    int mealId,
    String dishId,
  ) async {
    return await client.delete(
      '/meals/$mealId/dishes/$dishId',
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> updateDishInMeal({
    required int mealId,
    required int dishId,
    required UpdateDishInMealBody data,
  }) async {
    return await client.patch(
      '/meals/$mealId/dishes/$dishId',
      data: data,
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
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
    return await client.get(
      '/meals',
      queryParameters: queryParameters,
      fromJson: MealsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> addMeal(AddMealBody data) async {
    return await client.post(
      '/meals',
      data: data,
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> getMealById(int mealId) async {
    return await client.get(
      '/meals/$mealId',
      fromJson: MealsListItem.fromJson,
    );
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
    return await client.get(
      '/planned-meals',
      queryParameters: queryParameters,
      fromJson: MealsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> addPlannedMeal(AddPlannedMealBody data) async {
    return await client.post(
      '/planned-meals',
      data: data,
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> getPlannedMealById(int mealId) async {
    return await client.get(
      '/planned-meals/$mealId',
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> updatePlannedMeal(
    int mealId,
    UpdatePlannedMealBody data,
  ) async {
    return await client.patch(
      '/planned-meals/$mealId',
      data: data,
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> removePlannedMeal(int mealId) async {
    return await client.delete(
      '/planned-meals/$mealId',
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> logPlannedMeal(LogPlannedMealBody data) async {
    return await client.post(
      '/planned-meals/log',
      data: data,
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> removeMeal(int mealId) async {
    return await client.delete(
      '/meals/$mealId',
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> addFoodItemToMeal(
    int mealId,
    String foodItemId,
    AddFoodItemToMealBody data,
  ) async {
    return await client.post(
      '/meals/$mealId/food-items/$foodItemId',
      data: data,
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> addManyFoodItemsToMeal(
    int mealId,
    AddManyFoodItemsToMealBody data,
  ) async {
    return await client.post(
      '/meals/$mealId/food-items',
      data: data,
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> updateFoodItemInMeal(
    int mealId,
    int foodItemId,
    AddFoodItemToMealBody data,
  ) async {
    return await client.patch(
      '/meals/$mealId/food-items/$foodItemId',
      data: data,
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> removeFoodItemFromMeal(
    int mealId,
    String foodItemId,
  ) async {
    return await client.delete(
      '/meals/$mealId/food-items/$foodItemId',
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, SearchResponse>> search(String query,
      {List<String>? mode, int? page, int? limit, CancelToken? cancelRequestToken}) async {
    return await client.get(
      '/nutrition/search',
      cancelToken: cancelRequestToken,
      queryParameters: {
        'query': query,
        if (mode != null && mode.isNotEmpty) 'modes': mode,
        if (limit != null) 'pageSize': limit,
        if (page != null) 'page': page,
      },
      fromJson: SearchResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, GetDashboardWeightsResponse>> getDashboardWeights(
    String startDate,
    String endDate,
  ) async {
    return await client.get(
      '/weight/logs',
      queryParameters: {"startDate": startDate, "endDate": endDate},
      fromJson: GetDashboardWeightsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, LogWeightResponse>> logWeight(
    LogWeightBody data,
  ) async {
    return await client.post(
      '/weight/log',
      data: data,
      fromJson: LogWeightResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, GetDishesResponse>> getDishes(
    List<String>? mealCategories,
  ) async {
    return await client.get(
      '/dishes',
      queryParameters: {"mealCategories": mealCategories ?? []},
      fromJson: GetDishesResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> getDishById(
    int id,
  ) async {
    return await client.get(
      '/dishes/$id',
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> createDishFromRecipe(
    CreateDishFromRecipeBody data,
  ) async {
    return await client.post(
      '/dishes/recipes',
      data: data,
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> createDishFromMeal(
    CreateDishFromMealBody data,
  ) async {
    return await client.post(
      '/meals/dishes',
      data: data,
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> createDish(
    CreateDishBody data,
  ) async {
    return await client.post(
      '/dishes',
      data: data,
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> updateDishById(
    int id,
    UpdateDishBody data,
  ) async {
    return await client.patch(
      '/dishes/$id',
      data: data,
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> updateFoodItemInDish(
    int dishId,
    String internalFoodItemId,
    UpdateFoodItemInDishBody data,
  ) async {
    return await client.patch(
      '/dishes/$dishId/food-items/$internalFoodItemId',
      data: data,
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> deleteFoodItemFromDish(
    int dishId,
    int internalFoodItemId,
  ) async {
    return await client.delete(
      '/dishes/$dishId/food-items/$internalFoodItemId',
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, MealsListItem>> addDishToMeal(
    int mealId,
    AddDishToMealBody data,
  ) async {
    return await client.post(
      '/meals/$mealId/dishes',
      data: data,
      fromJson: MealsListItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> cloneDish(
    CloneDishBody data,
  ) async {
    return await client.post(
      '/dishes/clone',
      data: data,
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> deleteDish(
    int dishId,
  ) async {
    return await client.delete(
      '/dishes/$dishId',
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, UpdateDishFoodItemResponse>> addFoodItemToDish(
    int dishId,
    AddFoodItemToDishBody data,
  ) async {
    return await client.post(
      '/dishes/$dishId/food-item',
      data: data,
      fromJson: UpdateDishFoodItemResponse.fromJson,
    );
  }
}
