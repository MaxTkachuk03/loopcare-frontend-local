import 'package:auto_route/annotations.dart';
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
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/nutrition_intake_button.dart';

@RoutePage()
class NutritionIntakePage extends StatelessWidget {
  const NutritionIntakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        return CustomScaffold.greenLightest(
          appBar: CustomAppBar.green(
            leading: CustomFilledIconButton.leadingGreenLighter(),
            title: 'Nutrition intake',
            // subtitle:
            //     LocalizedTexts.mealLog.tr().capitalizeEachWordFirstLetter(),
          ),
          body: state.maybeMap(
            orElse: () => const SizedBox.shrink(),
            mealsInfo: (mealsState) => CustomSafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Image(image: AppImages.nutrition),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.bitter600(
                          'When and why I ate',
                          style: context.textTheme.displayLarge,
                        ),
                        CustomText.w600(
                          '#dayDate',
                          style: context.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 30.0),
                        const CategoryLabel(
                          label: 'Select the food category',
                          color: AppColors.greenRegular,
                          textColor: AppColors.blueDarkest,
                        ),
                        const SizedBox(height: 20.0),
                        CustomText(
                          'Select the meal you want to answer the survey for.',
                          style:
                              context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NutritionIntakeButton(
                              text: 'Breakfast',
                              onPressed: () {},
                            ),
                            NutritionIntakeButton(
                              text: 'Lunch',
                              onPressed: () {},
                            ),
                            NutritionIntakeButton(
                              text: 'Dinner',
                              onPressed: () {},
                            ),
                            NutritionIntakeButton(
                              text: 'Snacks',
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppIcons.nutritionSubtract,
                            const SizedBox(width: 16.0),
                            CustomText.bitter600('Please log food',
                                style: context.textTheme.bodyLarge),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        CustomText(
                          'LeanOnMe doesn’t encourage unsustainable diets like whole-day fasting. Please log food in at least one category so we can complete our commitment together.',
                          textAlign: TextAlign.left,
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
