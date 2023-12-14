import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/log_planned_meals/widgets/planned_meal_carousel.dart';

class LogPlannedMealsPage extends StatelessWidget {
  final NameLabel selectedMealCategory;

  const LogPlannedMealsPage({super.key, required this.selectedMealCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: false,
        title: _appBarTitle(context),
        subtitle: _appBarSubtitle(context),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => context.router.pop(),
              icon: const Icon(
                Icons.close,
                color: AppColors.white,
                size: 28.0,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 28.0,
            ),
            Expanded(
              child: PlannedMealCarousel(
                selectedMealCategory: selectedMealCategory,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            MainContainer(
              child: OutlinedButton(
                onPressed: () => _onSkipPressed(context),
                child: const Text(LocalizedTexts.skip).tr(),
              ),
            ),
            const SizedBox(
              height: 28.0,
            ),
          ],
        ),
      ),
    );
  }

  String _appBarTitle(BuildContext context) {
    final state = context.read<MealsBloc>().state;

    final date = state.getCurrentDate.isoStringWithoutTime != DateTime.now().isoStringWithoutTime
        ? state.getCurrentDate.shortDate
        : "Today's";

    return '$date ${LocalizedTexts.plannedMeals.translation}';
  }

  String? _appBarSubtitle(BuildContext context) {
    final state = context.read<MealsBloc>().state;

    return state.getCurrentDate.isoStringWithoutTime != DateTime.now().isoStringWithoutTime
        ? null
        : state.getCurrentDate.shortDate;
  }

  _onSkipPressed(BuildContext context) {
    context.read<MealsBloc>().add(
          MealsEvent.addMeal(selectedMealCategory.name.toLowerCase()),
        );

    context.router.push(SelectFoodRoute(mealCategory: selectedMealCategory.name));
  }
}
