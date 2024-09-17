import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/favorites_item/favorites_item.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class FooterOverlay extends StatelessWidget {
  const FooterOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 16.0, bottom: 40.0),
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(color: AppColors.yellowLight),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SelectFoodBloc, SelectFoodState>(
            builder: (BuildContext context, state) {
              final count = state.selectedFavoritesItemsLength;

              return Text(
                '$count ${count > 1 ? LocalizedTexts.items.tr() : LocalizedTexts.item.tr()} ${LocalizedTexts.selected.tr()}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
              );
            },
          ),
          const SizedBox(
            height: 14.0,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _onDeselectAll(context),
                  child: Text(LocalizedTexts.deselectAll.tr()),
                ),
              ),
              const SizedBox(
                width: 14.0,
              ),
              Expanded(
                child: BlocBuilder<SelectFoodBloc, SelectFoodState>(
                    builder: (BuildContext context, state) {
                  return ElevatedButton(
                    onPressed: () => _onAdd(
                      context,
                      state.selectedFavoritesItemsList.toList(),
                    ),
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
    context.read<SelectFoodBloc>().add(const SelectFoodEvent.itemsDeselectAll());
  }

  void _onAdd(BuildContext context, List<FavoritesItem> foodItemList) {
    context.read<MealsBloc>().add(MealsEvent.createFromFavorites(foodItemList));

    context.router.pushNamed(AppRoutes.meal);
  }
}
