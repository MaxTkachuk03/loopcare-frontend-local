import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_summary/nutrition_summary.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

class FoodLoggingDashboard extends StatelessWidget {
  final DateTime selectedDay;

  const FoodLoggingDashboard({super.key, required this.selectedDay});

  void _onPressHandler(BuildContext context) => context.router.pushNamed(AppRoutes.dailyIntake);

  void onErrorHandler(BuildContext context) => context
      .read<MealsBloc>()
      .add(MealsEvent.fetchMeals(startDate: selectedDay, endDate: selectedDay));

  Color get _textColor => !selectedDay.isFuture ? AppColors.blueDarker : AppColors.greyLabel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: [
              DashboardCardTitle(
                onTap: () => _onPressHandler(context),
                highlightColor: AppColors.greenLightest,
                leadingIcon: AppIcons.customDashboardLogMeals,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.bitter600(
                      LocalizedTexts.mealLog.tr(),
                      style: context.textTheme.headlineSmall?.copyWith(color: _textColor),
                    ),
                  ],
                ),
                actionIcon: AppIcons.arrow,
                circleButton: false,
                editable: !selectedDay.isFuture,
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) => state.data.isNutritionScalesLocked
                    ? const SizedBox.shrink()
                    : const Divider(color: AppColors.blueOffRegular),
              ),
              state.maybeMap(
                loading: (_) => const Loader(),
                error: (s) {
                  final error = s.data.error;

                  return ErrorScreen(error: error!, onButtonPressed: () => onErrorHandler(context));
                },
                orElse: () => NutritionSummary(
                  proteinDegree: state.data.selectedDayMealProteinDegreeSum,
                  calorieDensity: state.data.selectedDayMealCalorieDensitySum,
                  fiber: state.data.selectedDayMealFiber,
                  carbFiberRatio: state.data.selectedDayMealCarbFiberRatio,
                  carbsPercent: state.data.selectedDayMealCarbsPercent,
                  totalCalories: state.data.selectedDayMealTotalCaloriesWithDrinks,
                  totalCarbs: state.data.selectedDayMealTotalCarbs,
                  showCaloriesTracker: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
