import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/nutrition_intake_goal_progress/nutrition_intake_goal_progress.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/nutrition_intake_bloc.dart';

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
    required this.lessonDate,
  });

  final String text;
  final void Function()? onPressed;

  final int? mealId;
  final MealCategory category;
  final double? calorieDensity;
  final List<MealItem>? mealItems;
  final bool isDisabled;
  final NutritionIntakeGoalProgress? progress;
  final DateTime lessonDate;

  void _onTapHandler(BuildContext context) {
    if (isDisabled && mealId == null) return;

    if (mealId == null) {
      context.read<MealsBloc>().add(MealsEvent.addMeal(category));
    } else {
      context.read<MealsBloc>().add(MealsEvent.setMealId(mealId!, category));
    }
    context.router.push(const MealRoute());
  }

  void _goToNutritionTest(BuildContext context, int lessonId) {
    context.read<InteractiveLessonsBloc>().add(
        InteractiveLessonsEvent.getInteractiveLesson(
            lessonId: lessonId, date: lessonDate));

    context.read<MealsBloc>().add(MealsEvent.setMealId(mealId!, category));

    context
        .read<NutritionIntakeBloc>()
        .add(NutritionIntakeEvent.getLessonId(iLessonId: lessonId));

    context
        .read<InteractiveLessonsBloc>()
        .add(InteractiveLessonsEvent.setMealCategory(category.originalValue));

    context.read<InteractiveLessonsBloc>().add(
        InteractiveLessonsEvent.setAnswerDate(lessonDate.toIso8601String()));

    Future.delayed(
      const Duration(milliseconds: 1200),
      () {
        if (context.mounted) {
          context.router.pushNamed(AppRoutes.interactiveLesson);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isThisCategory = (mealId != null &&
        category.title.toLowerCase().contains(text.toLowerCase()));

    final bool isCompleted = progress?.isLessonFinished == true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            mealId != null && calorieDensity != null
                ? _goToNutritionTest(context, progress!.iLessonId)
                : _onTapHandler(context);
          },
          child: Container(
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
            child: isThisCategory && calorieDensity != null
                ? isCompleted
                    ? AppIcons.doneDayButton
                    : AppIcons.commitmentButton
                : AppIcons.intakePlus,
          ),
        ),
        const SizedBox(height: 5.0),
        CustomText.w700(
          text,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
              color: isThisCategory && calorieDensity != null
                  ? AppColors.blueDarkest
                  : AppColors.greyLight),
        ),
      ],
    );
  }
}
