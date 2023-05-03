import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/logged_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/nutrition_block/calorie_nutrition_block.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class LogMeal extends StatelessWidget {
  final bool isEditable;

  const LogMeal({
    Key? key,
    required this.isEditable,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    ModalBottomSheet.selectAMealDialog(
      context: context,
      filledList: context.read<MealsBloc>().state.filledCategories,
      currentDate: context.read<MealsBloc>().state.getCurrentDate,
      list: MealCategory.values
          .map(
            (e) => NameLabel(
              name: e.name,
              label: e.label ?? '',
              icon: e.icon,
            ),
          )
          .toList(),
      onSelect: (NameLabel item) {
        context.read<MealsBloc>().add(
              MealsEvent.addMeal(
                item.name.toLowerCase(),
              ),
            );

        context.router.push(SelectFoodRoute(mealCategory: item.name));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 24.0,
        right: 16.0,
        left: 16.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: BlocBuilder<MealsBloc, MealsState>(
          builder: (BuildContext context, mealsState) {
        return Column(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocalizedTexts.logYourMeals.translation,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontFamily: ThemeConstants.bitterFontFamily,
                                color: mealsState.isEnableOnDashboard
                                    ? AppColors.darkGreen
                                    : AppColors.greyLabel,
                              ),
                        ),
                        if (mealsState.filledCategories.isEmpty)
                          Text(
                            mealsState.isEnableOnDashboard
                                ? LocalizedTexts.noMealsLoggedYet.translation
                                : LocalizedTexts.noMealsLogged.translation,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: mealsState.isEnableOnDashboard
                                          ? AppColors.darkGreen
                                          : AppColors.greyLabel,
                                    ),
                          ),
                      ],
                    ),
                  ],
                ),
                mealsState.isEnableOnDashboard
                    ? Hexagon(
                        width: 54,
                        height: 54,
                        borderRadius: 16,
                        innerWidget: Container(
                          color: AppColors.bgGreen,
                          child: IconButton(
                            icon: ImageIcon(
                              mealsState.filledCategories.isNotEmpty
                                  ? AppIcons.edit
                                  : AppIcons.plus,
                              color: AppColors.darkGreen,
                              size: 18,
                            ),
                            onPressed: () => onPressHandler(context),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            mealsState.filledCategories.isNotEmpty
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
                                          .bodySmall
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
                                  filledList: mealsState.filledCategories,
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
                : const SizedBox(),
          ],
        );
      }),
    );
  }
}
