import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_text_area_history.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/meal_timing_content/meal_timing_content.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/meal_timing/custom_time_picker.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
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
  final Set<InteractiveLessonHistory> componentHistory = {};
  final List<DateTime> snacksTime = [];

  @override
  void initState() {
    super.initState();
    if (widget.component.progress == null) {
      return;
    }

    final history = widget.component.progress!.history!;
    componentHistory.addAll(history.toSet());
  }

  int _getMealList(List<MealItem> currentFoodItems, MealCategory category) {
    if (category == MealCategory.inbetweens) {
      currentFoodItems.sort((a, b) => a.id.compareTo(b.id));
      meals = currentFoodItems.toSet();
    } else {
      meals.add(currentFoodItems.last);
    }

    return meals.length;
  }

  void _snackTimes() {
    componentHistory.clear();
    // Перевірка, чи існує прогрес
    if (widget.component.progress != null) {
      final history = widget.component.progress!.history!;
      // Додаємо існуючі дані в componentHistory, якщо вони ще не додані
      componentHistory.addAll(history.toSet());
    }

    // Проходимо по кожному елементу meals
    for (int index = 0; index < meals.length; index++) {
      final meal = meals.toList()[index];

      // Перевірка, чи існує відповідний елемент у componentHistory
      if (index < componentHistory.length &&
          meal.id == componentHistory.toList()[index].mealItemId) {
        print(" meal.id ${meal.id}");
        print(
            "componentHistory[index].mealItemId:  ${componentHistory.toList()[index].mealItemId}");
        // Оновлюємо існуючий елемент у componentHistory
        componentHistory.toList()[index] = InteractiveLessonHistory(
          mealItemId: meal.id,
          id: meal.id,
          updatedAt: componentHistory.toList()[index].updatedAt,
          createdAt: meal.createdAt.toLocal(),
          text: 'snacks', // Позначка для оновлених елементів
        );
      } else {
        // Додаємо новий елемент у componentHistory, якщо його ще немає
        componentHistory.add(InteractiveLessonHistory(
          mealItemId: meal.id,
          id: meal.id,
          updatedAt: meal.updatedAt.toLocal(),
          createdAt: meal.createdAt.toLocal(),
          text: 'snacks', // Новий запис
        ));
      }
    }
  }

  // void _snackTimes() {
  //   // Перевірка, чи існує прогрес
  //   componentHistory.clear();
  //   if (widget.component.progress != null) {
  //     final history = widget.component.progress!.history!;
  //     // Додаємо існуючі дані в componentHistory, якщо вони ще не додані
  //     componentHistory.addAll(history);
  //   }

  //   // Поки кількість елементів у componentHistory менша, ніж у meals
  //   while (componentHistory.length < meals.length) {
  //     // Додаємо нові записи у componentHistory, щоб відповідати кількості meals
  //     final newMeal = meals.toList()[componentHistory.length];
  //     // Отримуємо відповідний meal
  //     componentHistory.add(InteractiveLessonHistory(
  //       mealItemId: newMeal.id,
  //       id: newMeal.id,
  //       updatedAt: newMeal.updatedAt.toLocal(),
  //       createdAt: newMeal.createdAt.toLocal(),
  //       text: 'snacks', // Додаємо необхідний текст
  //     ));
  //   }

  //   // print("@@@@ ${componentHistory}");
  // }

  MealTimingContent get content => widget.component.content;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, mealsState) {
        final category = mealsState.data.currentMealCategory!;
        _snackTimes();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryLabel.interactiveLesson(
              label: LocalizedTexts.mealTiming.tr(),
              lessonStreamType: widget.lessonStreamType,
            ),
            const SizedBox(height: 20),
            CustomText(
              content.question,
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 8.0),
              itemCount:
                  _getMealList(mealsState.data.currentFoodItems, category),
              itemBuilder: (context, index) {
                final meal = meals.toList()[index];
                final mealName = meal.name;
                // SJC remove? final time = mealsState.data.currentDateTime ?? meal.createdAt.toLocal();
                // warning • The left operand can't be null, so the right operand is never executed • lib/features/education/presentation/interactive_lessons/widgets/components/meal_timing/meal_timing.dart:81:65 • dead_null_aware_expression
                final secondTime = meal.createdAt;
                final time = widget.component.progress != null
                    ? category == MealCategory.inbetweens
                        ? componentHistory.toList()[index].updatedAt!
                        : widget.component.progress!.history!.last.updatedAt!
                    : meal.updatedAt.toLocal();

                print("HISTORY ${componentHistory}");
                return GestureDetector(
                  onTap: () async {
                    await showAdaptiveDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) => CustomTimePicker(
                        index: index,
                        initialTime: time,
                        onSaveProgress: widget.onSaveProgress,
                        component: widget.component,
                        lessonStreamType: widget.lessonStreamType,
                        mealName: mealName,
                        category: category.originalValue,
                        id: meal.id,
                        secondTime: secondTime,
                        componentHistory: componentHistory.toList(),
                      ),
                    );
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: CustomText.w400(
                        category == MealCategory.inbetweens
                            ? mealName
                            : category.title,
                      )),
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
                            CustomText.w400(
                                '${time.hour12}:${time.minute >= 10 ? time.minute : '0${time.minute}'}'),
                            CustomText.w400(
                              time.isPm ? ' PM' : ' AM',
                              style: context.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
