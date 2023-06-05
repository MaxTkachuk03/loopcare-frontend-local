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
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_planned_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_recipe_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_action_mode/meal_action_modes.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
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
    on<SetPlannedMeal>(_onSetPlannedMeal);
    on<AddMeal>(_onAddMeal);
    on<AddPlannedMeal>(_onAddPlannedMeal);
    on<UpdateFoodItemInMeal>(_onUpdateFoodItemInMeal);
    on<DeleteMeal>(_onDeleteMeal);
    on<DeleteFoodItemFromMeal>(_onDeleteFoodItemFromMeal);
    on<DeleteRecipeFromMeal>(_onDeleteRecipeFromMeal);
    on<CreateFromFavorites>(_onCreateFromFavorites);
    on<SetCurrentDate>(_onSetCurrentDate);
    on<AddFoodItemToMeal>(_onAddFoodItemToMeal);
    on<AddRecipeToMeal>(_onAddRecipeToMeal);
    on<AddDishToMeal>(_onAddDishToMeal);
    on<NutritionItemChanged>(_onNutritionItemChanged);
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

  Map<String, List<MealsListItem>> _combinePlannedMealsByDate(
    Map<String, List<MealsListItem>>? previousMealsData,
    List<MealsListItem> data,
  ) {
    Map<String, List<MealsListItem>> meals =
        Map<String, List<MealsListItem>>.from(previousMealsData ?? {});

    for (var element in data) {
      final loggingDate = element.planningDates;
      if (loggingDate == null) continue;

      List<MealsListItem> dayData =
          meals[loggingDate.first.isoStringWithoutTime] ?? <MealsListItem>[];
      final isAlreadyExist = dayData.contains(element);
      if (isAlreadyExist) continue;

      dayData.add(element);
      meals[loggingDate.first.isoStringWithoutTime] = dayData;
    }

    return meals;
  }

  FutureOr<void> _onSetCurrentDate(
    SetCurrentDate event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (s) async {
        emit(s.copyWith(
          currentDate: event.currentDate,
        ));

        if (event.currentDate.isBefore(DateTime.now())) {
          final meals = state.mapOrNull(mealsInfo: (s) => s.meals);
          final plannedMeals =
              state.mapOrNull(mealsInfo: (s) => s.plannedMeals);

          emit(const MealsState.loading());

          final response = await nutritionService.getMeals(
            startDate: event.currentDate.isoStringWithoutTime,
            endDate: event.currentDate.isoStringWithoutTime,
          );

          response.fold(
            (l) => emit(MealsState.error(l)),
            (r) => emit(
              MealsState.mealsInfo(
                currentDate: event.currentDate,
                meals: {
                  ...meals ?? {},
                  ...{event.currentDate.isoStringWithoutTime: r.data},
                },
                selectedServing: null,
                plannedMeals: plannedMeals ?? {},
              ),
            ),
          );

          return;
        }

        if (state.isPossibleToPlanMeal) {
          final plannedMeals =
              state.mapOrNull(mealsInfo: (s) => s.plannedMeals);
          final meals = state.mapOrNull(mealsInfo: (s) => s.meals);

          emit(const MealsState.loading());

          final response = await nutritionService.getPlannedMeals(
            startDate: event.currentDate.isoStringWithoutTime,
            endDate: event.currentDate.isoStringWithoutTime,
          );

          response.fold(
            (l) => emit(MealsState.error(l)),
            (r) => emit(
              MealsState.mealsInfo(
                currentDate: event.currentDate,
                meals: meals ?? {},
                selectedServing: null,
                plannedMeals: {
                  ...plannedMeals ?? {},
                  ...{event.currentDate.isoStringWithoutTime: r.data},
                },
              ),
            ),
          );

          return;
        }
      },
    );
  }

  FutureOr<void> _onSetPlannedMeal(
    SetPlannedMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (s) async {
        emit(
          s.copyWith(
            mealActionMode: MealActionModes.mealPlanning,
            currentMealCategory: event.meal.mealCategory,
            currentMealId: event.meal.id,
          ),
        );
      },
    );
  }

  FutureOr<void> _onFetchMeals(
    FetchMeals _,
    Emitter<MealsState> emit,
  ) async {
    emit(const MealsState.loading());

    final mealsResponses = await Future.wait([
      nutritionService.getMeals(
        startDate: DateTime.now()
            .subtract(const Duration(days: 8))
            .isoStringWithoutTime,
        endDate: DateTime.now().isoStringWithoutTime,
      ),
      nutritionService.getPlannedMeals(
        startDate: DateTime.now().isoStringWithoutTime,
        endDate: DateTime.now().isoStringWithoutTime,
      )
    ]);

    final mealsMap = mealsResponses.first
        .fold((l) => null, (r) => _combineMealsByDate({}, r.data));
    if (mealsMap == null) {
      mealsResponses.first.leftMap((l) => emit(MealsState.error(l)));

      return;
    }

    final plannedMealsMap = mealsResponses.last
        .fold((l) => null, (r) => _combinePlannedMealsByDate({}, r.data));
    if (plannedMealsMap == null) {
      mealsResponses.last.leftMap((l) {
        emit(MealsState.error(l));
      });

      return;
    }

    emit(
      MealsState.mealsInfo(
        currentDate: DateTime.now(),
        meals: mealsMap,
        plannedMeals: plannedMealsMap,
      ),
    );
  }

  FutureOr<void> _onFetchMealById(
    FetchMealById event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final response = state.isPlanningMeals
            ? await nutritionService.getPlannedMealById(event.id)
            : await nutritionService.getMealById(event.id);

        response.fold(
          (error) => null,
          (response) {
            final newState = state.isPlanningMeals
                ? state.copyWith(
                    plannedMeals: _getUpdatedMealsList(response),
                  )
                : state.copyWith(
                    meals: _getUpdatedMealsList(response),
                  );

            emit(newState);
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
          final newState = state.isPlanningMeals
              ? state.copyWith(plannedMeals: updatedList)
              : state.copyWith(meals: updatedList);
          emit(newState);
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
            final newState = state.isPlanningMeals
                ? state.copyWith(
                    plannedMeals: updatedList,
                  )
                : state.copyWith(
                    meals: updatedList,
                  );

            emit(newState);
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
            final newState = state.isPlanningMeals
                ? state.copyWith(plannedMeals: updatedList)
                : state.copyWith(meals: updatedList);

            emit(newState);
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
            final newState = state.isPlanningMeals
                ? state.copyWith(
                    plannedMeals: updatedList,
                  )
                : state.copyWith(
                    meals: updatedList,
                  );

            emit(newState);
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
            final newState = state.isPlanningMeals
                ? state.copyWith(plannedMeals: updatedList)
                : state.copyWith(meals: updatedList);

            emit(newState);
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
          final response = state.isPlanningMeals
              ? await nutritionService.removePlannedMeal(mealId)
              : await nutritionService.removeMeal(mealId);

          response.fold(
            (l) => null,
            (r) {
              final updatedList = _deleteMealFromList(mealId);
              final newState = state.isPlanningMeals
                  ? state.copyWith(
                      plannedMeals: updatedList,
                    )
                  : state.copyWith(
                      meals: updatedList,
                    );

              emit(newState);
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
              final newState = state.isPlanningMeals
                  ? state.copyWith(
                      currentMealId: mealId,
                      plannedMeals: updatedList,
                    )
                  : state.copyWith(currentMealId: mealId, meals: updatedList);

              emit(newState);
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
        emit(state.copyWith(
          mealActionMode: MealActionModes.mealLogging,
        ));

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
            final loggingDate = r.loggingDate;

            if (loggingDate == null) return;

            Map<String, List<MealsListItem>> meals =
                Map<String, List<MealsListItem>>.from(state.meals);
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
              state.copyWith(
                mealActionMode: MealActionModes.mealLogging,
                currentMealCategory: event.mealCategory,
                currentMealId: r.id,
                meals: meals,
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onAddPlannedMeal(
    AddPlannedMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        emit(state.copyWith(
          mealActionMode: MealActionModes.mealPlanning,
        ));

        final data = AddPlannedMealBody(
          planningDates: [
            state.currentDate?.toIso8601String() ??
                DateTime.now().toIso8601String(),
          ],
          mealCategory: event.mealCategory,
        );

        final response = await nutritionService.addPlannedMeal(data);

        response.fold(
          (l) => null,
          (r) {
            var updatedList = <MealsListItem>[];
            final planningDates = r.planningDates;

            if (planningDates == null) return;

            Map<String, List<MealsListItem>> meals =
                Map<String, List<MealsListItem>>.from(state.plannedMeals);
            var selectedDayMeals =
                meals[planningDates.first.isoStringWithoutTime] ??
                    <MealsListItem>[];

            if (selectedDayMeals.isEmpty) {
              updatedList = (selectedDayMeals.toList()..add(r)).toList();
            } else {
              if (!selectedDayMeals.any((item) => item.id == r.id)) {
                updatedList = (selectedDayMeals.toList()..add(r)).toList();
              } else {
                updatedList = selectedDayMeals;
              }
            }

            meals[planningDates.first.isoStringWithoutTime] = updatedList;

            emit(
              state.copyWith(
                mealActionMode: MealActionModes.mealPlanning,
                currentMealCategory: event.mealCategory,
                currentMealId: r.id,
                plannedMeals: meals,
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
        final date = state.isPlanningMeals
            ? mealItem.planningDates?.first ?? state.currentDate
            : mealItem.loggingDate;

        if (date == null) return state.mealsMap;

        Map<String, List<MealsListItem>> meals =
            Map<String, List<MealsListItem>>.from(state.mealsMap);
        var selectedDayMeals =
            meals[date.isoStringWithoutTime] ?? <MealsListItem>[];
        var updatedSelectedDayMeals = selectedDayMeals
            .map((e) => e.id == mealItem.id ? mealItem : e)
            .toList();

        meals[date.isoStringWithoutTime] = updatedSelectedDayMeals;

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
            state.mealsMap.map((key, value) => MapEntry(key, [...value]));
        var selectedDayMeals =
            meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        selectedDayMeals.removeWhere((e) => e.id == mealItem);

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
        final currentDate = state.isPlanningMeals
            ? event.meal.planningDates?.first ?? state.currentDate
            : event.meal.loggingDate;
        if (currentDate == null) return;

        Map<String, List<MealsListItem>> meals =
            Map<String, List<MealsListItem>>.from(state.mealsMap);
        var selectedDayMeals =
            meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final updatedSelectedDayMeals = selectedDayMeals.map((meal) {
          return meal.id == event.meal.id ? event.meal : meal;
        }).toList();

        meals[currentDate.isoStringWithoutTime] = updatedSelectedDayMeals;

        final newState = state.isPlanningMeals
            ? state.copyWith(
                plannedMeals: meals,
              )
            : state.copyWith(
                meals: meals,
              );

        emit(newState);
      },
    );
  }

  FutureOr<void> _onNutritionItemChanged(
    NutritionItemChanged event,
    Emitter<MealsState> emit,
  ) {
    state.mapOrNull(
      mealsInfo: (state) {
        emit(
          state.copyWith(currentNutritionType: event.item),
        );
      },
    );
  }
}
