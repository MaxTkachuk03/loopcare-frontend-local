import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';

import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/meal_timing_content/meal_timing_content.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';
import 'package:moment_dart/moment_dart.dart';

class MealTiming extends StatefulWidget {
  const MealTiming({
    super.key,
    required this.component,
    required this.lessonStreamType,
    required this.onSaveProgress,
  });

  final InteractiveLessonChunkComponentMealTiming component;
  final RiverModuleStreamType lessonStreamType;
  final Function(InteractiveLessonComponentProgress progress,
      InteractiveLessonChunkComponent component) onSaveProgress;

  @override
  State<MealTiming> createState() => _MealTimingState();
}

class _MealTimingState extends State<MealTiming> {
  Set<MealItem> meals = {};
  @override
  initState() {
    super.initState();
    if (widget.component.progress == null) return;
  }

  int _mealList(List<MealItem> currentFoodItems, MealCategory category) {
    if (category == MealCategory.inbetweens) {
      meals = currentFoodItems.toSet();
    } else {
      // if (!meals.contains(currentFoodItems.last)) {
      //   meals.add(
      //       currentFoodItems.last); // додає їжу лише якщо її немає в списку
      // }
      meals.add(currentFoodItems.last);
    }

    return meals.length;
  }

  MealTimingContent get content => widget.component.content;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, mealsState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryLabel.interactiveLesson(
              label: 'Meal Timing',
              lessonStreamType: widget.lessonStreamType,
            ),
            const SizedBox(height: 20),
            CustomText(
              content.markdown,
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 8.0),
              itemCount: _mealList(mealsState.data.currentFoodItems,
                  mealsState.data.currentMealCategory!),
              itemBuilder: (context, index) {

print("meals.length: ${meals.length}");

                final meal = meals.toList()[index];
                final mealName = meal.name;
                final time = meal.createdAt;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: CustomText.w400(mealName)),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blueDarker),
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppIcons.clock,
                          const SizedBox(width: 4.0),
                          CustomText.w400('${time.hour12}:${time.minute}'),
                          CustomText.w400(
                            time.isPm ? ' PM' : ' AM',
                            style: context.textTheme.labelSmall,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
