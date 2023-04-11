import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/dish_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/list_filters.dart';

class DishesList extends StatelessWidget {
  const DishesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<SelectFoodBloc, SelectFoodState>(
          builder: (BuildContext context, state) {
            return state.maybeMap(
              selectFood: (selectFoodState) {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListFilters(
                        title: LocalizedTexts.myLunchDishes.translation,
                        mealsList:
                            selectFoodState.mealFavoritesCategories.toList(),
                        onConfirmed: (list) => _onConfirmed(context, list),
                      ),
                      selectFoodState.dishes.isEmpty
                          ? MainContainer(
                              child: Text(
                                LocalizedTexts.emptyList.translation,
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: selectFoodState.dishes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return const DishListItem(
                                    dishItem: {},
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }

  _onConfirmed(
    BuildContext context,
    List<MealCategoryFilter> updatedFiltersList,
  ) {}
}
