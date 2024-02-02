import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

class SelectedItemsLabel extends StatelessWidget {
  const SelectedItemsLabel({super.key});

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
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: state.isPlanningMeals ? AppColors.petrolLighter : AppColors.greenDarker,
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
                            return CustomText.w600(
                              '${state.currentFoodItems.length}',
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.greenDarker,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24.0),
          ],
        );
      },
    );
  }
}
