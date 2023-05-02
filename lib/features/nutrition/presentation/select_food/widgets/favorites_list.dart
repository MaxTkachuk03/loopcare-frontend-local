import 'package:flutter/material.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/favorite_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/footer_overlay.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/list_filters.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<SelectFoodBloc, SelectFoodState>(
          builder: (BuildContext context, state) {
            return state.maybeMap(
              selectFood: (selectFoodState) {
                final String title = selectFoodState.hasOneSelectedMealCategorie
                    ? '${LocalizedTexts.my.translation} ${selectFoodState.selectedMealCategories[0].name}'
                    : LocalizedTexts.myFavorites.translation;

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListFilters(
                        title: title,
                        mealsList:
                            selectFoodState.mealFavoritesCategories.toList(),
                        onConfirmed: (list) => _onConfirmed(context, list),
                      ),
                      selectFoodState.favorites.isEmpty
                          ? MainContainer(
                              child: Text(
                                LocalizedTexts.emptyList.translation,
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: selectFoodState.favorites.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return FavoriteListItem(
                                    foodItem: selectFoodState.favorites[index],
                                  );
                                },
                              ),
                            ),
                      state.selectedFavoritesItemsLength > 0
                          ? const FooterOverlay()
                          : const SizedBox.shrink()
                    ],
                  ),
                );
              },
              loading: (state) => const Expanded(child: Loader()),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }

  _onConfirmed(
      BuildContext context, List<MealCategoryFilter> updatedFiltersList) {
    context
        .read<SelectFoodBloc>()
        .add(SelectFoodEvent.filterFavorites(updatedFiltersList.toIList()));
  }
}
