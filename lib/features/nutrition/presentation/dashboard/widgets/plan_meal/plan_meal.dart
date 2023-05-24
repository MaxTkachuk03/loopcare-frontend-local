import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

class PlanMeal extends StatelessWidget {
  final bool isEditable;

  const PlanMeal({
    Key? key,
    required this.isEditable,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    ModalBottomSheet.selectAMealDialog(
      context: context,
      filledList: context.read<MealsBloc>().state.filledPlannedMealCategories,
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
        context
            .read<MealsBloc>()
            .add(MealsEvent.addPlannedMeal(item.name.toLowerCase()));

        context.router.push(SelectFoodRoute(mealCategory: item.name));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        final currentPlannedMeals = state.maybeMap(
            mealsInfo: (s) =>
                s.plannedMeals[s.currentDate?.isoStringWithoutTime]
                    ?.where((element) => element.mealItems.isNotEmpty)
                    .toList() ??
                <MealsListItem>[],
            orElse: () => <MealsListItem>[]);

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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Image(
                        image: AppIcons.dashbordPlanMeals,
                      ),
                      const SizedBox(width: 24.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocalizedTexts.planYourMeals.translation,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontFamily: ThemeConstants.bitterFontFamily,
                                  color: state.isPossibleToPlanMeal
                                      ? AppColors.darkGreen
                                      : AppColors.greyLabel,
                                ),
                          ),
                          if (currentPlannedMeals.isEmpty)
                            Text(
                              state.isPossibleToPlanMeal
                                  ? LocalizedTexts.noMealsPlannedYet.translation
                                  : LocalizedTexts.noMealsPlanned.translation,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: state.isPossibleToPlanMeal
                                        ? AppColors.darkGreen
                                        : AppColors.greyLabel,
                                  ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  if (state.isPossibleToPlanMeal)
                    Hexagon(
                      width: 54,
                      height: 54,
                      borderRadius: 16,
                      innerWidget: Container(
                        color: AppColors.bgGreen,
                        child: IconButton(
                          icon: ImageIcon(
                            isEditable ? AppIcons.edit : AppIcons.plus,
                            color: AppColors.darkGreen,
                            size: 18,
                          ),
                          onPressed: () => onPressHandler(context),
                        ),
                      ),
                    ),
                ],
              ),
              currentPlannedMeals.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 8.0),
                        const Divider(color: AppColors.yellowLight),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: currentPlannedMeals.length,
                          itemBuilder: (BuildContext context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${state.getCurrentDate.isoStringWithoutTime} ${currentPlannedMeals[index].mealCategory}"
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              fontSize: 12.0,
                                              color: AppColors.greyLabel,
                                            ),
                                      ),
                                      Text(
                                        currentPlannedMeals[index]
                                            .mealItems
                                            .map((e) => e.name)
                                            .join(', '),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(fontSize: 12.0),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                                const Image(
                                  image: AppIcons.arrow,
                                  color: AppColors.greyLabel,
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 14.0);
                          },
                        ),
                      ],
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }
}
