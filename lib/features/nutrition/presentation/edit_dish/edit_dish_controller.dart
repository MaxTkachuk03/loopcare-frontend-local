import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class EditDishController {
  EditDishController({
    required EditDishBloc editDishBloc,
    required this.retryEvent,
    required this.mode,
  }) : _editDishBloc = editDishBloc {
    _editDishBloc.add(retryEvent);
    servingController.text = editDishBloc.state.data.servingAmount;
    portionsController.text = editDishBloc.state.data.numberOfPortions;

    servingsAmount = ValueNotifier(double.parse(editDishBloc.state.data.numberOfServings));
  }

  late final ValueNotifier<double> servingsAmount;

  final ValueNotifier<MealCategory> selectedMealCategory = ValueNotifier(MealCategory.breakfast);

  final TextEditingController servingController = TextEditingController();
  final TextEditingController portionsController = TextEditingController();
  final TextEditingController dishNameController = TextEditingController();

  final FocusNode servingFocusNode = FocusNode();
  final FocusNode portionsFocusNode = FocusNode();
  final FocusNode dishNameFocusNode = FocusNode();

  final EditDishEvent retryEvent;
  final EditDishPageMode mode;

  final EditDishBloc _editDishBloc;
  bool _isChangesSaved = false;

  void dispose() {
    servingFocusNode.dispose();
    portionsFocusNode.dispose();
    dishNameFocusNode.dispose();

    servingController.dispose();
    dishNameController.dispose();
    portionsController.dispose();

    servingsAmount.dispose();
    selectedMealCategory.dispose();
  }

  void addFoodItemToDish(
    double numberOfUnits,
    String servingId,
    String externalFoodItemId,
  ) =>
      _editDishBloc.add(
        EditDishEvent.addFoodItemToDish(
          numberOfUnits: numberOfUnits,
          servingId: servingId,
          externalFoodItemId: externalFoodItemId,
        ),
      );

  void servingChanged(String value) {
    servingsAmount.value = double.parse(value.isEmpty ? '0' : value);
    servingController.text = value;
  }

  void onPop() {
    if (mode == EditDishPageMode.create && !_isChangesSaved) {
      deleteDish();
    }
  }

  String? validate() {
    if (dishNameController.text.isEmpty) {
      return LocalizedTexts.invalidDishNameMessage.tr();
    }
    if (portionsController.text.isEmpty) {
      return LocalizedTexts.invalidDishPortionsAmountMessage.tr();
    }
    if (servingController.text.isEmpty) {
      return LocalizedTexts.invalidDishServingsAmountMessage.tr();
    }

    return null;
  }

  void saveDish() {
    _editDishBloc.add(EditDishEvent.updateDish(
      name: dishNameController.text,
      numberOfUnits: double.parse(servingController.text.replaceCommaWithDot.deleteDotAtTheEnd),
      numberOfServings: double.parse(portionsController.text),
      mealCategories: [selectedMealCategory.value],
    ));

    _isChangesSaved = true;
  }

  void deleteFoodItem(FoodItem item) {
    final dishId = _editDishBloc.state.data.currentDish?.id;

    if (dishId == null) return;

    _editDishBloc.add(
      EditDishEvent.deleteFoodItemFromDish(
        dishId: dishId,
        internalFoodItemId: int.parse(item.id),
      ),
    );
  }

  void updateFoodItemInDish(DishFoodItem item, double numberOfUnits, String servingId) {
    final dishId = _editDishBloc.state.data.currentDish?.id;

    if (dishId == null) return;

    _editDishBloc.add(
      EditDishEvent.updateFoodItemInDish(
        dishId: dishId,
        internalFoodItemId: item.id.toString(),
        numberOfUnits: numberOfUnits,
        servingId: servingId,
      ),
    );
  }

  void nutritionFactSelect(NutritionValuesTypes item) =>
      _editDishBloc.add(EditDishEvent.nutritionItemChanged(item));

  void retry() {
    _editDishBloc.add(retryEvent);
  }

  void updateFields(EditDishData data) {
    dishNameController.text = data.currentDish?.name ?? '';
    servingController.text = data.numberOfServings;
    portionsController.text = data.numberOfPortions;
    servingsAmount.value = double.parse(data.numberOfServings);
  }

  void deleteDish() => _editDishBloc.add(const EditDishEvent.deleteDish());
}
