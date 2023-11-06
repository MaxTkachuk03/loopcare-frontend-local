import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/nutrition/application/choose_date/choose_date_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

class PlanMeal extends StatelessWidget {
  final bool isEditable;

  const PlanMeal({
    Key? key,
    required this.isEditable,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    context.read<ChooseDateBloc>().add(
          ChooseDateEvent.setCurrentDate(
            context.read<MealsBloc>().state.getCurrentDate,
          ),
        );
    context.router.push(const WeekPlannerRoute());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          error: (errorState) {
            final error = errorState.fetchError;

            return Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: ErrorScreen(
                smallVersion: true,
                error: error,
                onButtonPressed: () => context.read<MealsBloc>().add(const MealsEvent.fetchMeals()),
              ),
            );
          },
          orElse: () {
            final currentPlannedMeals = state.todaysLoggedPlannedMeals;

            currentPlannedMeals.sort((a, b) => a.order.compareTo(b.order));

            return Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Image(image: AppIcons.dashbordPlanMeals),
                          const SizedBox(width: 24.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocalizedTexts.planYourMeals.translation,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                          width: 42,
                          height: 42,
                          borderRadius: 16,
                          innerWidget: Container(
                            color: AppColors.bgGreen,
                            child: IconButton(
                              icon: ImageIcon(
                                isEditable ? AppIcons.edit : AppIcons.plus,
                                color: AppColors.darkGreen,
                                size: 12,
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
                                return Material(
                                  child: InkWell(
                                    onTap: () => _onMealTap(context, currentPlannedMeals[index]),
                                    child: Ink(
                                      color: AppColors.white,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  currentPlannedMeals[index].mealCategory.toUpperCase(),
                                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                                      ),
                                    ),
                                  ),
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
      },
    );
  }

  _onMealTap(BuildContext context, MealsListItem meal) {
    context
      ..read<MealsBloc>().add(MealsEvent.setPlannedMeal(meal))
      ..router.pushNamed(AppRoutes.meal);
  }
}
