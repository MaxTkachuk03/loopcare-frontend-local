import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/interactive_lessons_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
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
  final Function(
          InteractiveLessonComponentProgress progress, InteractiveLessonChunkComponent component)
      onSaveProgress;

  @override
  State<MealTiming> createState() => _MealTimingState();
}

class _MealTimingState extends State<MealTiming> {
  Set<MealItem> meals = {};

  @override
  void initState() {
    super.initState();
    if (widget.component.progress == null) {
      return;
    }

    context.read<InteractiveLessonsBloc>().add(const InteractiveLessonsEvent.getMealTime());
  }

  int _getMealList(List<MealItem> currentFoodItems, MealCategory category) {
    if (category == MealCategory.inbetweens) {
      meals = currentFoodItems.toSet();
    } else {
      meals.add(currentFoodItems.last);
    }

    return meals.length;
  }

  MealTimingContent get content => widget.component.content;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InteractiveLessonsBloc, InteractiveLessonsState>(
      builder: (context, interactiveState) {
        final initialTime = interactiveState.data.answerDate.isNotEmpty
            ? DateTime.parse(interactiveState.data.answerDate)
            : DateTime.now();
        return BlocBuilder<MealsBloc, MealsState>(
          builder: (context, mealsState) {
            final category = mealsState.data.currentMealCategory!;
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
                  style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(height: 8.0),
                  itemCount: _getMealList(mealsState.data.currentFoodItems, category),
                  itemBuilder: (context, index) {
                    final meal = meals.toList()[index];
                    final mealName = meal.name;
                    final secondTime = meal.createdAt;

                    final finalTime = category != MealCategory.inbetweens
                        ? (widget.component.progress != null &&
                                widget.component.progress!.history != null &&
                                widget.component.progress!.history!.isNotEmpty
                            ? widget.component.progress!.history![index].updatedAt!
                            : meal.updatedAt.toLocal())
                        : (interactiveState.data.mealsTime.isNotEmpty
                            ? interactiveState.data.mealsTime[index]
                            : content.meals[index].mealCategory ==
                                    MealCategory.inbetweens.originalValue
                                ? content.meals[index].mealItems[index].updatedAt
                                : meal.updatedAt.toLocal());

                    return GestureDetector(
                      onTap: () async {
                        await showAdaptiveDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) => CustomTimePicker(
                            index: index,
                            initialTime: initialTime,
                            onSaveProgress: widget.onSaveProgress,
                            component: widget.component,
                            lessonStreamType: widget.lessonStreamType,
                            mealName: mealName,
                            category: category,
                            id: meal.id,
                            secondTime: secondTime,
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
                            category == MealCategory.inbetweens ? mealName : category.title,
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
                                    '${finalTime.hour12}:${finalTime.minute >= 10 ? finalTime.minute : '0${finalTime.minute}'}'),
                                CustomText.w400(
                                  finalTime.isPm ? ' PM' : ' AM',
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
      },
    );
  }
}
