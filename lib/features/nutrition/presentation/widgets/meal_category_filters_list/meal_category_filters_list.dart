import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/checkbox/custom_checkbox.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/food_item_servings_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';

typedef OnFilterPressedCb = void Function(BuildContext context, bool value, String name);

class MealCategoryFiltersList extends StatelessWidget {
  final OnFilterPressedCb onFilterPressed;

  const MealCategoryFiltersList({
    super.key,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodItemServingsBloc, FoodItemServingsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          orElse: () => const SizedBox.shrink(),
          foodItemServings: (foodItemServingsState) {
            return Column(
                children: foodItemServingsState.mealCategoryFilters.map((filter) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: AppColors.bgGreen),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: CustomCheckbox.blue(
                        value: filter.selected,
                        onChanged: (value) => onFilterPressed(
                          context,
                          value ?? false,
                          filter.name,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(child: CustomText.w400(filter.title.tr()))
                  ],
                ),
              );
            }).toList());
          },
        );
      },
    );
  }
}
