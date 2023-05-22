import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_action_mode/meal_action_modes.dart';

class SelectedItemsLabel extends StatelessWidget {
  const SelectedItemsLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return Row(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.router.pushNamed(AppRoutes.meal);
                },
                child: Ink(
                  height: 40.0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: state.isPlanningMeals
                        ? AppColors.blueMid
                        : AppColors.darkGreen,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Row(
                    children: [
                      const ImageIcon(
                        AppIcons.list,
                        color: AppColors.white,
                      ),
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 22.0,
                          minWidth: 22.0,
                        ),
                        padding: const EdgeInsets.all(2.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: BlocBuilder<MealsBloc, MealsState>(
                            builder: (BuildContext context, state) {
                          return Text(
                            '${state.currentFoodItems.length}',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: AppColors.darkGreen,
                                      fontWeight: FontWeight.w600,
                                    ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 24.0,
            ),
          ],
        );
      },
    );
  }
}
