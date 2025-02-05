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
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class DishListItem extends StatelessWidget {
  final Dish dishItem;

  const DishListItem({
    super.key,
    required this.dishItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectFoodBloc, SelectFoodState>(
      builder: (BuildContext context, state) {
        final isSelected = state.mapOrNull(
                selectFood: (state) =>
                    state.selectedDishesItems.contains(dishItem)) ??
            false;

        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 6.0),
              onTap: () => _onChanged(!isSelected, dishItem, context),
              title: Row(
                children: [
                  CustomCheckbox.blue(
                    value: isSelected,
                    onChanged: (bool? value) =>
                        _onChanged(value, dishItem, context),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.w600(
                          dishItem.name,
                          style: context.textTheme.bodySmall,
                        ),
                        CustomText.w400(
                            '${dishItem.numberOfServings} ${LocalizedTexts.serving.tr()}',
                            maxLines: 1,
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: AppColors.greyLight)),
                      ],
                    ),
                  ),
                  if (!isSelected)
                    IconButton(
                      splashRadius: 20,
                      onPressed:
                          isSelected ? null : () => _onTap(context, dishItem),
                      icon: const ImageIcon(
                        AppIcons.arrow,
                        color: AppColors.greyLight,
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.blueLighter),
          ],
        );
      },
    );
  }

  void _onChanged(bool? value, Dish foodItem, BuildContext context) {
    final val = value ?? false;
    final bloc = context.read<SelectFoodBloc>();

    if (val) {
      bloc.add(SelectFoodEvent.dishAdded(foodItem));
    } else {
      bloc.add(SelectFoodEvent.dishDeleted(foodItem));
    }
  }

  _onTap(BuildContext context, Dish item) {
    context.router.push(
      DishDetailsRoute(
        dishId: item.id,
        canEditDish: true,
      ),
    );
  }
}
