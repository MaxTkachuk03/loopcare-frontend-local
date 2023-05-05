import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/dish_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/list_filters.dart';

class DishesList extends StatefulWidget {
  const DishesList({super.key});

  @override
  State<DishesList> createState() => _DishesListState();
}

class _DishesListState extends State<DishesList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool wantKeepAlive = true;

  @override
  void initState() {
    context.read<SelectFoodBloc>().add(const SelectFoodEvent.fetchDishes());
    super.initState();
  }

  Future _onRefresh() async {
    return context
        .read<SelectFoodBloc>()
        .add(const SelectFoodEvent.fetchDishes());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<SelectFoodBloc, SelectFoodState>(
          builder: (BuildContext context, state) {
            return state.maybeMap(
              selectFood: (selectFoodState) {
                final String title = selectFoodState.hasOneSelectedDishCategory
                    ? '${LocalizedTexts.my.translation} ${selectFoodState.selectedDishCategories[0].name}'
                    : LocalizedTexts.myDishes.translation;

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListFilters(
                        title: title,
                        mealsList:
                            selectFoodState.dishFavoritesCategories.toList(),
                        onConfirmed: (list) => _onConfirmed(context, list),
                      ),
                      selectFoodState.dishes.isEmpty
                          ? MainContainer(
                              child: Text(
                                LocalizedTexts.emptyList.translation,
                              ),
                            )
                          : Expanded(
                              child: RefreshIndicator(
                                onRefresh: _onRefresh,
                                child: ListView.builder(
                                  itemCount: selectFoodState.dishes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return DishListItem(
                                      dishItem: selectFoodState.dishes[index],
                                    );
                                  },
                                ),
                              ),
                            ),
                      const SizedBox(height: 8.0),
                      MainContainer(
                        child: OutlinedRoundedButton(
                          text: LocalizedTexts.createMyDish.translation,
                          icon: AppIcons.dish,
                          onPressed: _onCreateDish,
                        ),
                      )
                    ],
                  ),
                );
              },
              loading: (_) => const Expanded(child: Loader()),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }

  _onCreateDish() {
    context.router.pushNamed(AppRoutes.createDish);
  }

  _onConfirmed(
      BuildContext context, List<MealCategoryFilter> updatedFiltersList) {
    context
        .read<SelectFoodBloc>()
        .add(SelectFoodEvent.filterDishes(updatedFiltersList.toIList()));
  }
}
