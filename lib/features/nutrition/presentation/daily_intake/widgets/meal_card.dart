import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_indicator_color_picker.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

class MealCard extends StatelessWidget {
  final int? mealId;
  final String title;
  final double? calorieDensity;
  final List<MealItem>? mealItems;
  final bool isDisabled;

  const MealCard({
    super.key,
    required this.mealId,
    required this.title,
    required this.calorieDensity,
    required this.mealItems,
    required this.isDisabled,
  });

  void _onTapHandler(BuildContext context) {
    if (isDisabled && mealId == null) return;

    if (mealId == null) {
      final mealCategory = title.toLowerCase();

      context.read<MealsBloc>().add(MealsEvent.addMeal(mealCategory));
    } else {
      context.read<MealsBloc>().add(MealsEvent.setMealId(mealId!, title));
    }

    context.router.pushNamed(AppRoutes.meal);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTapHandler(context),
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 6,
                      backgroundColor: NutritionIndicatorColorPicker.getIndicatorColor(
                          NutritionIndicatorType.calorieDensity, calorieDensity),
                    ),
                    const SizedBox(width: 10.0),
                    CustomText.bitter600(title.capitalize(), style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                if (!isDisabled || mealId != null)
                  ImageIcon(mealId == null ? AppIcons.plus : AppIcons.arrow, color: AppColors.blueDarker)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
