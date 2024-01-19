import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';

class DishListItem extends StatelessWidget {
  final Dish dishItem;

  const DishListItem({
    super.key,
    required this.dishItem,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => _onTap(context, dishItem),
        child: Ink(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.w600(
                dishItem.name,
                style: context.textTheme.bodySmall,
              ),
              CustomText.w400(
                '${dishItem.numberOfServings} ${LocalizedTexts.serving.translation}',
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
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
