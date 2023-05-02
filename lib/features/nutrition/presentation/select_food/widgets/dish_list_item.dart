import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
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
        onTap: () => _onTap(context),
        child: Ink(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dishItem.name,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                '${dishItem.numberOfServings} ${LocalizedTexts.serving.translation}',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: AppColors.greyLabel,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onTap(BuildContext context) {}
}
