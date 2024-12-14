import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/interactive_lessons_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/nutrition_intake_done_lessons/nutrition_intake_done_lessons.dart';
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
    this.progress,
  });

  final String text;
  final void Function()? onPressed;

  final int? mealId;
  final MealCategory category;
  final double? calorieDensity;
  final List<MealItem>? mealItems;
  final bool isDisabled;
  final NutritionIntakeDoneLessons? progress;

  void _onTapHandler(BuildContext context) {
    if (isDisabled && mealId == null) return;

    if (mealId == null) {
      context.read<MealsBloc>().add(MealsEvent.addMeal(category));
    } else {
      context.read<MealsBloc>().add(MealsEvent.setMealId(mealId!, category));
    }
    context.router.push(const MealRoute());
  }

  void _goToNutritionTest(BuildContext context) {
    if (mealId != null && category.title.toLowerCase().contains('snacks'.toLowerCase())) {
      context
          .read<InteractiveLessonsBloc>()
          .add(const InteractiveLessonsEvent.getInteractiveLesson(lessonId: 2));
    } else {
      // TODO: delete bloc init after connecting to backend
      context
          .read<InteractiveLessonsBloc>()
          .add(const InteractiveLessonsEvent.getInteractiveLesson(lessonId: 1));
    }

    context.read<MealsBloc>().add(MealsEvent.setMealId(mealId!, category));

    Future.delayed(
      const Duration(milliseconds: 800),
      () {
        if (context.mounted) {
          context.router.pushNamed(AppRoutes.interactiveLesson);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isThisCategory =
        (mealId != null && category.title.toLowerCase().contains(text.toLowerCase()));

    final bool isCompleted = progress?.isCompleted == true;
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
                spreadRadius: -13,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CirclePlusButton(
                icon: isThisCategory
                    ? isCompleted
                        ? AppIcons.doneDayButton
                        : AppIcons.commitmentButton
                    : null,
                color: isThisCategory
                    ? isCompleted
                        ? AppColors.greenLight
                        : AppColors.greenLightest
                    : AppColors.greenLightest,
                onPressed: () {
                  mealId != null && calorieDensity != null
                      ? _goToNutritionTest(context)
                      : _onTapHandler(context);
                },
                width: 0,
                iconColor: mealId != null && calorieDensity != null
                    ? isCompleted
                        ? AppColors.white
                        : AppColors.greenLight
                    : null,
              ),
              isThisCategory && isCompleted
                  ? Positioned(
                      right: -5,
                      top: -10,
                      child: badge.Badge(
                        badgeStyle: const badge.BadgeStyle(
                          padding: EdgeInsets.all(5.0),
                          badgeColor: AppColors.blueRegular,
                          elevation: 0,
                        ),
                        badgeAnimation: const badge.BadgeAnimation.slide(toAnimate: false),
                        position: badge.BadgePosition.topEnd(top: -8, end: -4),
                        badgeContent: const Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(
                            Icons.check,
                            color: AppColors.white,
                            size: 25.0 * 0.44,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
        const SizedBox(height: 5.0),
        CustomText.w700(
          text,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium
              ?.copyWith(color: isThisCategory ? AppColors.blueDarkest : AppColors.greyLight),
        ),
      ],
    );
  }
}
