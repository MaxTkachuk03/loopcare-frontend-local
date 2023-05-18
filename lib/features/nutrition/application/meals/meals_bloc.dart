import 'dart:async';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_items_list_element.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_many_food_items_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_recipe_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

part 'meals_event.dart';

part 'meals_state.dart';

part 'meals_bloc.freezed.dart';

@singleton
class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final NutritionService nutritionService;

  MealsBloc(this.nutritionService) : super(const MealsState.initial()) {
    on<FetchMeals>(_onFetchMeals);
    on<FetchMealById>(_onFetchMealById);
    on<AddMeal>(_onAddMeal);
    on<UpdateFoodItemInMeal>(_onUpdateFoodItemInMeal);
    on<DeleteMeal>(_onDeleteMeal);
    on<DeleteFoodItemFromMeal>(_onDeleteFoodItemFromMeal);
    on<DeleteRecipeFromMeal>(_onDeleteRecipeFromMeal);
    on<CreateFromFavorites>(_onCreateFromFavorites);
    on<SetMealId>(_onSetMealId);
    on<SetCurrentDate>(_onSetCurrentDate);
    on<AddFoodItemToMeal>(_onAddFoodItemToMeal);
    on<AddRecipeToMeal>(_onAddRecipeToMeal);
    on<AddDishToMeal>(_onAddDishToMeal);
    on<NutritionItemChanged>(_onNutritionItemChanged);
  }

  Map<String, List<MealsListItem>> _combineMealsByDate(
    Map<String, List<MealsListItem>>? previousWeightsData,
    List<MealsListItem> data,
  ) {
    Map<String, List<MealsListItem>> meals =
        Map<String, List<MealsListItem>>.from(previousWeightsData ?? {});

    for (var element in data) {
      List<MealsListItem> dayData =
          meals[element.loggingDate.isoStringWithoutTime] ?? <MealsListItem>[];
      dayData.add(element);
      meals[element.loggingDate.isoStringWithoutTime] = dayData;
    }

    return meals;
  }

  FutureOr<void> _onSetCurrentDate(
    SetCurrentDate event,
    Emitter<MealsState> emit,
  ) async {
    if (event.currentDate.isAfter(DateTime.now())) {
      emit(
        MealsState.mealsInfo(
          currentDate: event.currentDate,
          meals: {},
        ),
      );
    } else {
      final meals = state.mapOrNull(mealsInfo: (s) => s.meals);

      emit(const MealsState.loading());

      final response = await nutritionService.getMeals(
        startDate: event.currentDate.isoStringWithoutTime,
        endDate: event.currentDate.isoStringWithoutTime,
      );

      response.fold(
        (error) {
          emit(MealsState.error(error));
        },
        (response) {
          emit(
            MealsState.mealsInfo(
              currentDate: event.currentDate,
              meals: _combineMealsByDate(meals, response.data),
              selectedServing: null,
            ),
          );
        },
      );
    }
  }

  FutureOr<void> _onSetMealId(
    SetMealId event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        emit(
          state.copyWith(currentMealId: event.mealId),
        );
      },
    );
  }

  FutureOr<void> _onFetchMeals(
    FetchMeals _,
    Emitter<MealsState> emit,
  ) async {
    final meals = state.mapOrNull(mealsInfo: (s) => s.meals);

    emit(const MealsState.loading());

    final response = await nutritionService.getMeals(
      startDate:
          DateTime.now().subtract(const Duration(days: 8)).isoStringWithoutTime,
      endDate: DateTime.now().isoStringWithoutTime,
    );

    response.fold(
      (error) {
        emit(MealsState.error(error));
      },
      (response) {
        emit(
          MealsState.mealsInfo(
            currentDate: DateTime.now(),
            meals: _combineMealsByDate(meals, response.data),
          ),
        );
      },
    );
  }

  FutureOr<void> _onFetchMealById(
    FetchMealById event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final response = await nutritionService.getMealById(event.id);

        response.fold(
          (error) => null,
          (response) {
            final updatedList = _getUpdatedMealsList(response);
            emit(
              state.copyWith(
                meals: updatedList,
                currentMeal: response,
                currentNutritionItem: response.serving.list.firstWhere(
                  (element) =>
                      element.key == NutritionValuesTypes.calories.name,
                ),
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onAddRecipeToMeal(
    AddRecipeToMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        const numberOfUnits = 1;

        const data = AddRecipeToMealBody(
          numberOfUnits: numberOfUnits,
        );

        final response = await nutritionService.addRecipeToMeal(
          mealId: event.mealId,
          recipeId: event.recipeId,
          data: data,
        );

        response.fold((l) => null, (r) {
          final updatedList = _getUpdatedMealsList(r);
          emit(
            state.copyWith(
              meals: updatedList,
            ),
          );
        });
      },
    );
  }

  FutureOr<void> _onAddFoodItemToMeal(
    AddFoodItemToMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final response = await nutritionService.addFoodItemToMeal(
          event.mealId,
          event.foodItemId,
          event.data,
        );

        response.fold(
          (l) => null,
          (r) {
            final updatedList = _getUpdatedMealsList(r);
            emit(
              state.copyWith(
                meals: updatedList,
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onUpdateFoodItemInMeal(
    UpdateFoodItemInMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final servingId = state.selectedServing?.servingId;
        final numberOfUnits = state.selectedServing?.numberOfUnits;

        if (servingId == null) return;

        final data = AddFoodItemToMealBody(
          servingId: servingId,
          numberOfUnits: numberOfUnits,
        );

        final response = await nutritionService.updateFoodItemInMeal(
          event.mealId,
          event.foodItemId,
          data,
        );

        response.fold(
          (l) => null,
          (r) {
            final updatedList = _getUpdatedMealsList(r);

            emit(
              state.copyWith(
                meals: updatedList,
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onDeleteFoodItemFromMeal(
    DeleteFoodItemFromMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final mealId = state.getCurrentMealId;

        if (mealId == null) return;

        final response = await nutritionService.removeFoodItemFromMeal(
          mealId,
          event.foodItemId,
        );

        response.fold(
          (l) => null,
          (r) {
            final updatedList = _getUpdatedMealsList(r);
            emit(
              state.copyWith(
                meals: updatedList,
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onDeleteRecipeFromMeal(
    DeleteRecipeFromMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final mealId = state.getCurrentMealId;

        if (mealId == null) return;

        final response = await nutritionService.deleteRecipeFromMeal(
          mealId,
          event.recipeId,
        );

        response.fold(
          (l) => null,
          (r) {
            final updatedList = _getUpdatedMealsList(r);
            emit(
              state.copyWith(
                meals: updatedList,
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onDeleteMeal(
    DeleteMeal event,
    Emitter<MealsState> emit,
  ) async {
    if (event.mealId == null) {
      return;
    }
    await state.mapOrNull(
      mealsInfo: (state) async {
        final mealId = event.mealId;
        if (mealId != null) {
          final response = await nutritionService.removeMeal(
            mealId,
          );

          response.fold(
            (l) => null,
            (r) {
              final updatedList = _deleteMealFromList(mealId);
              emit(
                state.copyWith(
                  meals: updatedList,
                ),
              );
            },
          );
        }
      },
    );
  }

  FutureOr<void> _onCreateFromFavorites(
    CreateFromFavorites event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final mealId = state.currentMealId;
        if (mealId != null) {
          final manyFoodItemsListData = AddManyFoodItemsToMealBody(
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

          final response = await nutritionService.addManyFoodItemsToMeal(
            mealId,
            manyFoodItemsListData,
          );

          response.fold(
            (l) => null,
            (r) {
              final updatedList = _getUpdatedMealsList(r);

              emit(
                state.copyWith(
                  currentMealId: mealId,
                  meals: updatedList,
                ),
              );
            },
          );
        }
      },
    );
  }

  FutureOr<void> _onAddMeal(
    AddMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final data = AddMealBody(
          loggingDate: state.currentDate?.toIso8601String() ??
              DateTime.now().toIso8601String(),
          mealCategory: event.mealCategory,
        );

        final response = await nutritionService.addMeal(
          data,
        );

        response.fold(
          (l) => null,
          (r) {
            var updatedList = <MealsListItem>[];

            Map<String, List<MealsListItem>> meals =
                Map<String, List<MealsListItem>>.from(state.meals);
            var selectedDayMeals =
                meals[r.loggingDate.isoStringWithoutTime] ?? <MealsListItem>[];

            if (selectedDayMeals.isEmpty) {
              updatedList = (selectedDayMeals.toList()..add(r)).toList();
            } else {
              if (!selectedDayMeals.any((item) => item.id == r.id)) {
                updatedList = (selectedDayMeals.toList()..add(r)).toList();
              } else {
                updatedList = selectedDayMeals;
              }
            }

            meals[r.loggingDate.isoStringWithoutTime] = updatedList;

            emit(
              state.copyWith(
                currentMealCategory: event.mealCategory,
                currentMealId: r.id,
                meals: meals,
                currentMeal: r,
                currentNutritionItem: r.serving.list.firstWhere(
                  (element) =>
                      element.key == NutritionValuesTypes.calories.name,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Map<String, List<MealsListItem>> _getUpdatedMealsList(
    MealsListItem mealItem,
  ) {
    return state.maybeMap(
      mealsInfo: (state) {
        Map<String, List<MealsListItem>> meals =
            Map<String, List<MealsListItem>>.from(state.meals);
        var selectedDayMeals =
            meals[mealItem.loggingDate.isoStringWithoutTime] ??
                <MealsListItem>[];
        var updatedSelectedDayMeals = selectedDayMeals
            .map((e) => e.id == mealItem.id ? mealItem : e)
            .toList();

        meals[mealItem.loggingDate.isoStringWithoutTime] =
            updatedSelectedDayMeals;

        return meals;
      },
      orElse: () => {},
    );
  }

  Map<String, List<MealsListItem>> _deleteMealFromList(int mealItem) {
    return state.maybeMap(
      mealsInfo: (state) {
        final currentDate = state.currentDate ?? DateTime.now();
        Map<String, List<MealsListItem>> meals =
            Map<String, List<MealsListItem>>.from(state.meals);
        var selectedDayMeals =
            meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        selectedDayMeals.removeWhere((e) => e.id == mealItem);
        meals[currentDate.isoStringWithoutTime] = selectedDayMeals;

        return meals;
      },
      orElse: () => {},
    );
  }

  FutureOr<void> _onAddDishToMeal(
    AddDishToMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final currentDate = event.meal.loggingDate;
        Map<String, List<MealsListItem>> meals =
            Map<String, List<MealsListItem>>.from(state.meals);
        var selectedDayMeals =
            meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final updatedSelectedDayMeals = selectedDayMeals.map((meal) {
          return meal.id == event.meal.id ? event.meal : meal;
        }).toList();

        meals[currentDate.isoStringWithoutTime] = updatedSelectedDayMeals;

        emit(
          state.copyWith(
            meals: meals,
          ),
        );
      },
    );
  }

  FutureOr<void> _onNutritionItemChanged(
    NutritionItemChanged event,
    Emitter<MealsState> emit,
  ) {
    state.mapOrNull(mealsInfo: (state) {
      emit(state.copyWith(currentNutritionItem: event.item));
    });
  }
}
