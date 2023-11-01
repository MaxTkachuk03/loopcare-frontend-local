import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/grouped_meal_list/grouped_meal_list.dart';

class SelectedDayCard extends StatelessWidget {
  final String mealCategory;
  final List<MealItem> mealItems;

  const SelectedDayCard({
    Key? key,
    required this.mealItems,
    required this.mealCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Gap(18.0),
          const Divider(
            color: AppColors.bgGreen,
            thickness: 2.0,
            height: 2.0,
          ),
          const Gap(20.0),
          GroupedMealList(
            mealItems: mealItems,
          ),
          const Divider(
            color: AppColors.bgGreen,
            thickness: 2.0,
            height: 2.0,
          ),
          const Gap(30.0),
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
    );
  }

  void _onLogMealPressed(BuildContext context) {
    // context
    //   ..read<MealsBloc>().add(MealsEvent.logPlannedMeal(plannedMealId, mealCategory))
    //   ..router.pushNamed(AppRoutes.meal);
  }
}
