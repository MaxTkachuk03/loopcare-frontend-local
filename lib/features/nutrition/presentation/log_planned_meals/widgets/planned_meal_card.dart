import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/grouped_meal_list/grouped_meal_list.dart';

class PlannedMealCard extends StatelessWidget {
  final Map<String, List<MealItem>> mealItem;
  final int plannedMealId;
  final String mealCategory;

  const PlannedMealCard({
    Key? key,
    required this.mealItem,
    required this.plannedMealId,
    required this.mealCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MealsBloc, MealsState>(
      listener: _logPlannedMealListener,
      listenWhen: (prev, cur) {
        print('prev.mealsMap ${prev.mealsMap.length}  ${prev.mealsMap} ');
        print('cur.mealsMap ${cur.mealsMap.length} ${cur.mealsMap}');
        return !identical(prev.mealsMap, cur.mealsMap);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, left: 24.0, right: 24.0, bottom: 34.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mealCategory.capitalize(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.blueAppBar),
            ),
            const SizedBox(
              height: 18.0,
            ),
            const Divider(
              color: AppColors.bgGreen,
              thickness: 2.0,
              height: 2.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: GroupedMealList(
                mealItems: mealItem.values.first,
              ),
            ),
            const Divider(
              color: AppColors.bgGreen,
              thickness: 2.0,
              height: 2.0,
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () => _onLogMealPressed(context),
              style: Theme.of(context)
                  .elevatedButtonTheme
                  .style
                  ?.copyWith(minimumSize: MaterialStateProperty.all(const Size(146, 40))),
              child: const Text(LocalizedTexts.logAs).tr(
                namedArgs: {
                  'mealCategory': mealCategory,
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLogMealPressed(BuildContext context) {
    context.read<MealsBloc>().add(MealsEvent.logPlannedMeal(plannedMealId));
  }

  void _logPlannedMealListener(BuildContext context, MealsState state) {
    print('_logPlannedMealListener ${state.mealsMap} ${state.getCurrentMealId} ${state.currentMealCategory}');
    context.router.pushNamed(AppRoutes.meal);
  }
}
