import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/checkbox/custom_checkbox.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/favorites_item/favorites_item.dart';

class FavoriteListItem extends StatelessWidget {
  final FavoritesItem foodItem;

  const FavoriteListItem({
    super.key,
    required this.foodItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectFoodBloc, SelectFoodState>(
      builder: (BuildContext context, state) {
        final isSelected = state.mapOrNull(
                selectFood: (state) => state.selectedFavoritesItems.contains(foodItem)) ??
            false;

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 6.0),
          onTap: () => _onChanged(!isSelected, foodItem, context),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomCheckbox.blue(
                value: isSelected,
                onChanged: (bool? value) => _onChanged(value, foodItem, context),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.w600(
                      foodItem.foodName,
                      maxLines: 2,
                      style: context.textTheme.bodySmall,
                    ),
                    CustomText.w400(
                      '${foodItem.brandName} | ${foodItem.serving.servingDescription}',
                      maxLines: 1,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.greyLight,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isSelected)
                IconButton(
                  onPressed: isSelected ? null : () => _onTap(context),
                  icon: const ImageIcon(
                    AppIcons.arrow,
                    color: AppColors.greyLight,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _onChanged(bool? value, FavoritesItem foodItem, BuildContext context) {
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

    context.router.push(
      SelectServingRoute(
        foodItemId: foodItem.id,
        initialServingId: servingId,
        initialServingAmount: foodItem.serving.numberOfUnits,
        foodItemName: foodItem.foodName,
        onConfirm: (_, __) {},
      ),
    );
  }
}
