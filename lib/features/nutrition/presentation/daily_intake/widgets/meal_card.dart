import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/calorie_density_color.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/grouped_meal_list/grouped_meal_list.dart';

class MealCard extends StatelessWidget {
  final int mealId;
  final String title;
  final double calorieDensity;
  final List<MealItem> mealItems;

  const MealCard({
    super.key,
    required this.mealId,
    required this.title,
    required this.calorieDensity,
    required this.mealItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 22.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Hexagon(
                    width: 20,
                    height: 20,
                    borderRadius: 10,
                    innerWidget: Container(
                      color: getCalorieDensityColor(calorieDensity),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    title.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.greyLabel,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  context.read<MealsBloc>().add(
                        MealsEvent.setMealId(mealId, title),
                      );
                  context.router.pushNamed(AppRoutes.meal);
                },
                child: const ImageIcon(
                  AppIcons.arrow,
                  color: AppColors.greyLabel,
                ),
              )
            ],
          ),
          const SizedBox(height: 8.0),
          GroupedMealList(
            mealItems: mealItems,
          ),
        ],
      ),
    );
  }
}
