import 'dart:async';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_utils.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/add_dish_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_items_list_element.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_many_food_items_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_recipe_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/domain/favorites_item/favorites_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

part 'meals_event.dart';

part 'meals_state.dart';

part 'meals_bloc.freezed.dart';

@singleton
class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final NutritionService nutritionService;

  MealsBloc(this.nutritionService)
      : super(const MealsState.initial(MealsStateData())) {
    on<FetchMeals>(_onFetchMeals);
    on<FetchMealById>(_onFetchMealById);
    on<AddMeal>(_onAddMeal);
    on<UpdateFoodItemInMeal>(_onUpdateFoodItemInMeal);
    on<DeleteMeal>(_onDeleteMeal);
    on<DeleteFoodItemFromMeal>(_onDeleteFoodItemFromMeal);
    on<DeleteRecipeFromMeal>(_onDeleteRecipeFromMeal);
    on<DeleteDishFromMeal>(_onDeleteDishFromMeal);
    on<CreateFromFavorites>(_onCreateFromFavorites);
    on<SetCurrentDate>(_onSetCurrentDate);
    on<AddFoodItemToMeal>(_onAddFoodItemToMeal);
    on<AddRecipeToMeal>(_onAddRecipeToMeal);
    on<AddDishToMeal>(_onAddDishToMeal);
    on<NutritionItemChanged>(_onNutritionItemChanged);
    on<SetMealId>(_onSetMealId);
  }

  Map<String, List<MealsListItem>> _combineMealsByDate(
    Map<String, List<MealsListItem>>? previousMealsData,
    List<MealsListItem> data,
  ) {
    Map<String, List<MealsListItem>> meals =
        Map<String, List<MealsListItem>>.from(previousMealsData ?? {});

    for (var element in data) {
      final loggingDate = element.loggingDate;
      if (loggingDate == null) continue;

      List<MealsListItem> dayData =
          meals[loggingDate.isoStringWithoutTime] ?? <MealsListItem>[];
      final isAlreadyExist = dayData.contains(element);
      if (isAlreadyExist) continue;

      dayData.add(element);
      meals[loggingDate.isoStringWithoutTime] = dayData;
    }

    return meals;
  }

  FutureOr<void> _onSetCurrentDate(
    SetCurrentDate event,
    Emitter<MealsState> emit,
  ) async {
    if (event.currentDate.isFuture) return;

    emit(MealsState.loading(
        state.data.copyWith(isLoading: true, currentDate: event.currentDate)));
  }

  FutureOr<void> _onSetMealId(
    SetMealId event,
    Emitter<MealsState> emit,
  ) async {
    emit(
      MealsState.mealsInfo(state.data.copyWith(
          currentMealId: event.id, currentMealCategory: event.mealCategory)),
    );
  }

  FutureOr<void> _onFetchMeals(
    FetchMeals event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    final response = await nutritionService.getMeals(
      startDate: event.startDate.toIso8601String(),
      endDate: event.endDate.toIso8601String(),
    );

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(MealsState.mealsInfo(state.data
          .copyWith(meals: _combineMealsByDate({}, r.data), isLoading: false))),
    );
  }

  FutureOr<void> _onFetchMealById(
    FetchMealById event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    final response = await nutritionService.getMealById(event.id);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        emit(MealsState.mealsInfo(state.data
            .copyWith(meals: _getUpdatedMealsList(r), isLoading: false)));
      },
    );
  }

  FutureOr<void> _onAddRecipeToMeal(
    AddRecipeToMeal event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    const data = AddRecipeToMealBody(numberOfUnits: 1);

    final response = await nutritionService.addRecipeToMeal(
        mealId: event.mealId, recipeId: event.recipeId, data: data);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        emit(MealsState.mealsInfo(state.data
            .copyWith(meals: _getUpdatedMealsList(r), isLoading: false)));
      },
    );
  }

  FutureOr<void> _onAddDishToMeal(
    AddDishToMeal event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    final data = AddDishToMealBody(
        dishId: event.dishId,
        numberOfUnits: double.parse(event.numberOfServings));

    final response = await nutritionService.addDishToMeal(event.mealId, data);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(MealsState.mealsInfo(state.data
          .copyWith(meals: _getUpdatedMealsList(r), isLoading: false))),
    );
  }

  FutureOr<void> _onAddFoodItemToMeal(
    AddFoodItemToMeal event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    final response = await nutritionService.addFoodItemToMeal(
        event.mealId, event.foodItemId, event.data);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        emit(MealsState.mealsInfo(state.data
            .copyWith(meals: _getUpdatedMealsList(r), isLoading: false)));
      },
    );
  }

  FutureOr<void> _onUpdateFoodItemInMeal(
    UpdateFoodItemInMeal event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    final data = event.data;

    if (data.numberOfUnits == null || data.servingId.isEmpty) return;

    final response = await nutritionService.updateFoodItemInMeal(
        event.mealId, event.foodItemId, data);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        emit(MealsState.mealsInfo(state.data
            .copyWith(meals: _getUpdatedMealsList(r), isLoading: false)));
      },
    );
  }

  FutureOr<void> _onDeleteFoodItemFromMeal(
    DeleteFoodItemFromMeal event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    final mealId = state.data.getCurrentMealId;

    if (mealId == null) return;

    final response =
        await nutritionService.removeFoodItemFromMeal(mealId, event.foodItemId);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        emit(MealsState.mealsInfo(state.data
            .copyWith(meals: _getUpdatedMealsList(r), isLoading: false)));
      },
    );
  }

  FutureOr<void> _onDeleteRecipeFromMeal(
    DeleteRecipeFromMeal event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    final mealId = state.data.getCurrentMealId;

    if (mealId == null) return;

    final response =
        await nutritionService.deleteRecipeFromMeal(mealId, event.recipeId);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        emit(MealsState.mealsInfo(state.data
            .copyWith(meals: _getUpdatedMealsList(r), isLoading: false)));
      },
    );
  }

  FutureOr<void> _onDeleteDishFromMeal(
    DeleteDishFromMeal event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    final mealId = state.data.getCurrentMealId;

    if (mealId == null) return;

    final response =
        await nutritionService.deleteDishFromMeal(mealId, event.dishId);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        emit(MealsState.mealsInfo(state.data
            .copyWith(meals: _getUpdatedMealsList(r), isLoading: false)));
      },
    );
  }

  FutureOr<void> _onDeleteMeal(
    DeleteMeal event,
    Emitter<MealsState> emit,
  ) async {
    final mealId = event.mealId;

    if (mealId == null) return;

    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    final response = await nutritionService.removeMeal(mealId);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(MealsState.mealsInfo(state.data
          .copyWith(meals: _deleteMealFromList(mealId), isLoading: false))),
    );
  }

  Map<String, List<MealsListItem>> _deleteMealFromList(int mealId) {
    final currentDate = state.data.currentDateTime;

    Map<String, List<MealsListItem>> meals = {...state.data.mealsMap};

    var selectedDayMeals =
        meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

    selectedDayMeals.removeWhere((e) => e.id == mealId);

    return meals;
  }

  FutureOr<void> _onCreateFromFavorites(
    CreateFromFavorites event,
    Emitter<MealsState> emit,
  ) async {
    final mealId = state.data.currentMealId;

    if (mealId == null) return;

    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    final data = AddManyFoodItemsToMealBody(
      foodItems: event.foodItemList
          .map(
            (element) => AddFoodItemsListElement(
              externalFoodItemId: element.id,
              numberOfUnits: element.serving.numberOfUnits,
              servingId: element.serving.servingId ?? "0",
            ),
          )
          .toList(),
    );

    final response =
        await nutritionService.addManyFoodItemsToMeal(mealId, data);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        emit(
          MealsState.mealsInfo(state.data.copyWith(
            currentMealId: mealId,
            meals: _getUpdatedMealsList(r),
            isLoading: false,
          )),
        );
      },
    );
  }

  FutureOr<void> _onAddMeal(
    AddMeal event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsState.loading(state.data.copyWith(isLoading: true)));

    var loggingDate = state.data.currentDateTime.midnightTime.toIso8601String();

    final data = AddMealBody(
        loggingDate: loggingDate,
        mealCategory: event.mealCategory.originalValue);

    final response = await nutritionService.addMeal(data);

    response.fold(
      (l) => emit(
          MealsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        var updatedList = <MealsListItem>[];
        final loggingDate = r.loggingDate;

        if (loggingDate == null) return;

        Map<String, List<MealsListItem>> meals =
            Map<String, List<MealsListItem>>.from(state.data.meals);

        var selectedDayMeals =
            meals[loggingDate.isoStringWithoutTime] ?? <MealsListItem>[];

        if (selectedDayMeals.isEmpty) {
          updatedList = (selectedDayMeals.toList()..add(r)).toList();
        } else {
          if (!selectedDayMeals.any((item) => item.id == r.id)) {
            updatedList = (selectedDayMeals.toList()..add(r)).toList();
          } else {
            updatedList = selectedDayMeals;
          }
        }

        meals[loggingDate.isoStringWithoutTime] = updatedList;

        emit(
          MealsState.mealsInfo(
            state.data.copyWith(
              currentDate: loggingDate,
              currentMealCategory: event.mealCategory,
              currentMealId: r.id,
              meals: meals,
              isLoading: false,
            ),
          ),
        );
      },
    );
  }

  Map<String, List<MealsListItem>> _getUpdatedMealsList(
      MealsListItem mealItem) {
    final date = mealItem.loggingDate;

    if (date == null) return state.data.mealsMap;

    Map<String, List<MealsListItem>> meals =
        Map<String, List<MealsListItem>>.from(state.data.mealsMap);
    var selectedDayMeals =
        meals[date.isoStringWithoutTime] ?? <MealsListItem>[];
    var updatedSelectedDayMeals = selectedDayMeals
        .map((e) => e.id == mealItem.id ? mealItem : e)
        .toList();

    meals[date.isoStringWithoutTime] = updatedSelectedDayMeals;

    return meals;
  }

  FutureOr<void> _onNutritionItemChanged(
    NutritionItemChanged event,
    Emitter<MealsState> emit,
  ) {
    emit(MealsState.mealsInfo(
        state.data.copyWith(currentNutritionType: event.item)));
  }
}
