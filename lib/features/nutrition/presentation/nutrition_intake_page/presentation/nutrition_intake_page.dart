import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/commitment/application/commitment_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/continue_btn.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/nutrition_intake_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/presentation/nutrition_intake_button.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class NutritionIntakePage extends StatefulWidget {
  const NutritionIntakePage({super.key, @PathParam('source') this.source});

  final String? source;

  @override
  State<NutritionIntakePage> createState() => _NutritionIntakePageState();
}

class _NutritionIntakePageState extends State<NutritionIntakePage> {
  bool isSwitched = false;

  @override
  void initState() {
    context.read<NutritionIntakeBloc>().add(NutritionIntakeEvent.fetchProgress(
        date: context.read<MealsBloc>().state.data.currentDateTime));

    super.initState();
  }

  static final List<String> categories = [
    LocalizedTexts.breakfast.tr(),
    LocalizedTexts.lunch.tr(),
    LocalizedTexts.dinner.tr(),
    LocalizedTexts.inbetweens.tr().split('&').last.trim()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NutritionIntakeBloc, NutritionIntakeState>(
      listener: (context, nutritionState) {
        setState(() {
          isSwitched = nutritionState.data.isDayClosed;
        });
      },
      builder: (context, nutritionState) {
        final isCompleted = nutritionState.data.progress.any((c) => c.isLessonFinished == true);

        return BlocBuilder<MealsBloc, MealsState>(
          builder: (context, mealState) {
            final isAddFood = mealState.data.selectedDayMealTotalCaloriesWithDrinks == 0;

            final lessonDate = mealState.data.currentDateTime;
            return CustomScaffold.greenLightest(
              appBar: CustomAppBar.green(
                leading: CustomFilledIconButton.leadingGreenLighter(),
                title: LocalizedTexts.nutritionIntake.tr(),
              ),
              body: mealState.maybeMap(
                orElse: () => const SizedBox.shrink(),
                mealsInfo: (mealsState) => CustomSafeArea(
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Center(
                            child: Image(image: AppImages.nutrition),
                          ),
                          const SizedBox(height: 25.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText.bitter600(
                                  LocalizedTexts.whenAndWhyIAte.tr(),
                                  style: context.textTheme.displayLarge,
                                ),
                                CustomText.w600(
                                  mealState.data.currentDateTime.dateStringOnly,
                                  style: context.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 24.0),
                                CategoryLabel.nutritionIntake(),
                                const SizedBox(height: 12.0),
                                CustomText(
                                  isAddFood || isCompleted
                                      ? LocalizedTexts.mealYouWant.tr()
                                      : LocalizedTexts.youCanAnswer.tr(),
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 20.0),
                                Center(
                                  child: SizedBox(
                                    height: 100,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: MealCategory.values.length,
                                        itemBuilder: (context, index) {
                                          final selectedDayMeals = mealsState.data.meals[
                                              mealsState.data.currentDateTime.isoStringWithoutTime];
                                          var category = MealCategory.values[index];

                                          var mealForCurrentCategory =
                                              selectedDayMeals?.firstWhereOrNull((m) =>
                                                  m.mealCategory.toLowerCase() ==
                                                  MealCategory.values[index].originalValue);

                                          final mealItems = mealForCurrentCategory?.mealItems;
                                          final isEnabled =
                                              mealItems != null && mealItems.isNotEmpty;

                                          return NutritionIntakeButton(
                                            progress: nutritionState.data.progress.isNotEmpty
                                                ? nutritionState.data.progress[index]
                                                : null,
                                            mealId: mealForCurrentCategory?.id,
                                            category: category,
                                            isDisabled: !mealsState.data.isEditable,
                                            mealItems: isEnabled ? mealItems : null,
                                            calorieDensity: isEnabled
                                                ? mealsState.data.calorieDensitySum(mealItems)
                                                : null,
                                            text: categories[index],
                                            lessonDate: lessonDate,
                                          );
                                        },
                                        separatorBuilder: (_, __) {
                                          final screenWidth = MediaQuery.of(context).size.width;

                                          if (screenWidth < 390) {
                                            return SizedBox(width: screenWidth / 12);
                                          } else if (screenWidth < 400) {
                                            return SizedBox(width: screenWidth / 11);
                                          } else {
                                            return SizedBox(width: screenWidth / 10);
                                          }
                                        }),
                                  ),
                                ),
                                isAddFood && !isCompleted
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AppIcons.nutritionSubtract,
                                              const SizedBox(width: 16.0),
                                              CustomText.bitter600(
                                                  LocalizedTexts.pleaseLogFood.tr(),
                                                  style: context.textTheme.bodyLarge),
                                            ],
                                          ),
                                          const SizedBox(height: 12.0),
                                          CustomText(
                                            LocalizedTexts.leanOnMeDoesNot.tr(),
                                            textAlign: TextAlign.left,
                                            style: context.textTheme.bodyMedium,
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                                isCompleted
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CategoryLabel.nutritionIntake(),
                                          const SizedBox(height: 20.0),
                                          CustomText(
                                            LocalizedTexts.haveYouLogged.tr(),
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(fontWeight: FontWeight.w700),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Row(
                                            children: [
                                              Switch.adaptive(
                                                value: isSwitched,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (isSwitched == true) {
                                                      return;
                                                    }
                                                    context.read<NutritionIntakeBloc>().add(
                                                        NutritionIntakeEvent.completeDay(
                                                            date: lessonDate));

                                                    context.read<CommitmentBloc>().add(
                                                        CommitmentEvent.getCommitment(
                                                            date: lessonDate));
                                                  });
                                                },
                                                activeColor: AppColors.greenLight,
                                                inactiveThumbColor: AppColors.white,
                                                inactiveTrackColor: AppColors.greyLighter,
                                              ),
                                              CustomText(
                                                LocalizedTexts.thisDayIsComplete.tr(),
                                                style: context.textTheme.bodyMedium!
                                                    .copyWith(fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20.0),
                                          ContinueBtn(
                                              label: LocalizedTexts.backToPracticeBoard.tr(),
                                              onPressed: () {
                                                context.router.maybePop();
                                              },
                                              isDisable: false),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
