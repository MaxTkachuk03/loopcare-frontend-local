import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';
import 'package:loopcare_frontend/features/nutrition/domain/favorites_item/favorites_item.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class FooterOverlay extends StatelessWidget {
  final SearchMode mode;
  final TextEditingController? servingController;
  List<Dish>? dishes;

  FooterOverlay(
      {super.key, required this.mode, this.servingController, this.dishes});

  final usageAnalytics = UsageAnalytics();

  @override
  Widget build(BuildContext context) {
    final whichMode = mode == SearchMode.favorite;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
          right: 24.0, left: 24.0, top: 16.0, bottom: 40.0),
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(color: AppColors.yellowLight),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SelectFoodBloc, SelectFoodState>(
            builder: (BuildContext context, state) {
              final countFavorites = state.selectedFavoritesItemsLength;
              final countDish = state.selectedDishesItemsLength;

              return Text(
                '${whichMode ? countFavorites : countDish}  ${whichMode ? countFavorites > 1 ? LocalizedTexts.items.tr() : LocalizedTexts.item.tr() : countDish > 1 ? LocalizedTexts.items.tr() : LocalizedTexts.item.tr()} ${LocalizedTexts.selected.tr()}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontStyle: FontStyle.italic),
              );
            },
          ),
          const SizedBox(height: 14.0),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _onDeselectAll(context),
                  child: Text(LocalizedTexts.deselectAll.tr()),
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: BlocBuilder<SelectFoodBloc, SelectFoodState>(
                    builder: (BuildContext context, state) {
                  return ElevatedButton(
                    onPressed: whichMode
                        ? () => _onAdd(
                            context, state.selectedFavoritesItemsList.toList())
                        : () => _onLogDishHandler(context, dishes!),
                    child: Text(LocalizedTexts.add.tr()),
                  );
                }),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onDeselectAll(BuildContext context) {
    context.read<SelectFoodBloc>().add(SelectFoodEvent.itemsDeselectAll(mode));
  }

  void _onAdd(BuildContext context, List<FavoritesItem> foodItemList) {
    context.read<MealsBloc>().add(MealsEvent.createFromFavorites(foodItemList));

    context.router.pushNamed(AppRoutes.meal);
  }

  void _onLogDishHandler(BuildContext context, List<Dish> dishes) {
    final mealId = context.read<MealsBloc>().state.data.getCurrentMealId;

    final currentMeal = context.read<MealsBloc>().state.data.currentMeal;

    for (int i = 0; i < dishes.length; i++) {
      final dishId = dishes[i].id;

      if (mealId == null) return;

      final numberOfServings =
          servingController!.text.replaceCommaWithDot.deleteDotAtTheEnd;

      context
          .read<MealsBloc>()
          .add(MealsEvent.addDishToMeal(mealId, numberOfServings, dishId));

      context.router.maybePop();

      usageAnalytics.track(
        eventName: UsageAnalyticsEvents.mealLogged,
        attributes: {
          UsageAnalyticsAttributes.mealId: mealId,
          UsageAnalyticsAttributes.mealAmount: numberOfServings,
          UsageAnalyticsAttributes.foodLoggedFrom: 'meal',
          UsageAnalyticsAttributes.dishId: dishId,
          UsageAnalyticsAttributes.mealCategory: currentMeal?.mealCategory
        },
      );
    }
  }
}
