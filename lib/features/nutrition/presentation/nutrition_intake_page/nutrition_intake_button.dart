import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/circle_plus_button/circle_plus_button.dart';

class NutritionIntakeButton extends StatelessWidget {
  const NutritionIntakeButton({
    super.key,
    required this.text,
    this.onPressed,
    this.mealId,
    required this.category,
    this.calorieDensity,
    this.mealItems,
    required this.isDisabled,
  });

  final String text;
  final void Function()? onPressed;

  final int? mealId;
  final MealCategory category;
  final double? calorieDensity;
  final List<MealItem>? mealItems;
  final bool isDisabled;

  void _onTapHandler(BuildContext context) {
    if (isDisabled && mealId == null) return;

    if (mealId == null) {
      context.read<MealsBloc>().add(MealsEvent.addMeal(category));
    } else {
      context.read<MealsBloc>().add(MealsEvent.setMealId(mealId!, category));
    }
    context.router.push(MealRoute(source: 'commitment'));
  }

  @override
  Widget build(BuildContext context) {
    final bool isThisCategory = (mealId != null &&
        category.title.toLowerCase().contains(text.toLowerCase()));

//  category.title.toLowerCase() == text.toLowerCase()
    print("------${category.title.toLowerCase()}------");
    print("${text.toLowerCase()}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.greenDarker,
                offset: Offset(0, 12),
                blurRadius: 20.0,
                spreadRadius: -15,
              ),
            ],
          ),
          child: CirclePlusButton(
            icon: isThisCategory ? AppIcons.commitmentButton : null,
            color: AppColors.greenLightest,
            onPressed: () {
              mealId != null && calorieDensity != null
                  ? null
                  : _onTapHandler(context);
            },
            width: 0,
            iconColor: mealId != null && calorieDensity != null
                ? AppColors.greenLight
                : null,
          ),
        ),
        const SizedBox(height: 5.0),
        CustomText.w700(
          text,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
              color:
                  isThisCategory ? AppColors.blueDarkest : AppColors.greyLight),
        ),
      ],
    );
  }
}
