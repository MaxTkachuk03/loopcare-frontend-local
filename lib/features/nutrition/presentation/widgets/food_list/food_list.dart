// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_item/food_item.dart';

class FoodList extends StatelessWidget {
  final List<dynamic> list; // TODO: create model for item

  const FoodList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        // TODO: change to real list
        return FoodItem(
          foodItem: MealItem(
            id: '0',
            description: 'Name',
            calorieDensity: 0,
            proteinDegree: 0,
            serving: FoodItemServing(
              calcium: null,
              calories: 0,
              carbohydrate: 0,
              cholesterol: 0,
              fat: 0,
              favoriteMealCategories: [],
              fiber: 0,
              iron: null,
              isSelectedFavorite: null,
              measurementDescription: '',
              metricServingAmount: null,
              metricServingUnit: '',
              monounsaturatedFat: null,
              numberOfUnits: 0,
              polyunsaturatedFat: null,
              potassium: null,
              protein: 0,
              saturatedFat: 0,
              servingDescription: '',
              servingId: '',
              servingUrl: '',
              sodium: null,
              sugar: null,
              transFat: null,
              vitaminA: null,
              vitaminC: null,
            ),
            createdAt: DateTime.now(),
            name: '',
            type: '',
            updatedAt: DateTime.now(),
          ),
        );
      },
    );
  }
}
