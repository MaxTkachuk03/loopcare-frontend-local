import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_blue.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';

class FavoriteListItem extends StatelessWidget {
  final FoodItem foodItem;

  const FavoriteListItem({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectFoodBloc, SelectFoodState>(
      builder: (BuildContext context, state) {
        final isSelected = state.mapOrNull(
                selectFood: (state) =>
                    state.selectedFavoritesItems.contains(foodItem)) ??
            false;

        return Material(
          child: InkWell(
            onTap: isSelected ? null : () => _onTap(context),
            child: Ink(
              color: AppColors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 18.0,
                              height: 24.0,
                              child: CheckboxBlue(
                                value: isSelected,
                                onChanged: (bool? value) =>
                                    _onChanged(value, foodItem, context),
                              ),
                            ),
                            const SizedBox(
                              width: 14.0,
                            ),
                          ],
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                foodItem.foodName,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              AutoSizeText(
                                '${foodItem.brandName} | ${foodItem.serving.servingDescription}',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: AppColors.greyLabel,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  if (!isSelected)
                    const ImageIcon(
                      AppIcons.arrow,
                      color: AppColors.greyLabel,
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onChanged(bool? value, FoodItem foodItem, BuildContext context) {
    final val = value ?? false;
    final bloc = context.read<SelectFoodBloc>();

    if (val) {
      bloc.add(SelectFoodEvent.itemAdded(foodItem));
    } else {
      bloc.add(SelectFoodEvent.itemDeleted(foodItem));
    }
  }

  _onTap(BuildContext context) {
    final servingId = foodItem.serving.servingId;

    if (servingId == null) return;

    context.router.push(SelectServingRoute(
        foodItemId: foodItem.id,
        initialServingId: servingId,
        foodItemName: foodItem.foodName));
  }
}
