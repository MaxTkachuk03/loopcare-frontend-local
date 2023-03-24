import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';

class DefaultListItem extends StatelessWidget {
  final FoodItemServing item;
  final void Function(FoodItemServing item) onPressed;

  const DefaultListItem({
    Key? key,
    required this.item,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(item),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.check,
                  color: AppColors.greyMid,
                ),
                const SizedBox(width: 8.0),
                Text(
                  item.servingLabel,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Text(
              '${item.calories}',
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyLabel,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
