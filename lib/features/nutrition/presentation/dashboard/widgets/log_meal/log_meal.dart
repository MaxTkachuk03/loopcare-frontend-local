import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/logged_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/nutrition_block/calorie_nutrition_block.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

class LogMeal extends StatelessWidget {
  final bool isEditable;

  const LogMeal({
    Key? key,
    required this.isEditable,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    ModalBottomSheet.selectAMealDialog(
      context: context,
      list: MealCategory.values
          .map((e) => NameLabel(name: e.name, label: e.label ?? ''))
          .toList(),
      onSelect: (NameLabel item) {
        context.read<MealsBloc>().add(
              MealsEvent.addMeal(
                item.name.toLowerCase(),
              ),
            );

        context.router.pushNamed(AppRoutes.meal);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Image(
                    image: AppIcons.dashbordLogMeals,
                  ),
                  const SizedBox(width: 24.0),
                  Text(
                    LocalizedTexts.logYourMeals.translation,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontFamily: ThemeConstants.bitterFontFamily,
                        ),
                  ),
                ],
              ),
              BlocBuilder<MealsBloc, MealsState>(
                builder: (BuildContext context, state) {
                  return state.isEnableOnDashboard
                      ? Hexagon(
                          width: 54,
                          height: 54,
                          borderRadius: 16,
                          innerWidget: Container(
                            color: AppColors.bgGreen,
                            child: IconButton(
                              icon: ImageIcon(
                                state.filledCategories.isNotEmpty
                                    ? AppIcons.edit
                                    : AppIcons.plus,
                                color: AppColors.darkGreen,
                                size: 18,
                              ),
                              onPressed: () => onPressHandler(context),
                            ),
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
          BlocBuilder<MealsBloc, MealsState>(
              builder: (BuildContext context, state) {
            return state.filledCategories.isNotEmpty
                ? Column(
                    children: [
                      const SizedBox(height: 8.0),
                      const Divider(color: AppColors.yellowLight),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocalizedTexts.logged.translation
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                            fontSize: ThemeConstants.fontSize12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.greyLabel,
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    const ImageIcon(
                                      AppIcons.arrow,
                                      color: AppColors.greyLabel,
                                      size: 10,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                LoggedList(
                                  categoryList: MealCategory.values
                                      .map((e) =>
                                          e.shortLabel
                                              ?.capitalizeOnlyFirstLetter() ??
                                          '')
                                      .toList(),
                                  categoryListRaw: MealCategory.values
                                      .map((e) => e.label ?? '')
                                      .toList(),
                                  filledList: state.filledCategories,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 40),
                          const CalorieNutritionBlock(),
                        ],
                      ),
                    ],
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
