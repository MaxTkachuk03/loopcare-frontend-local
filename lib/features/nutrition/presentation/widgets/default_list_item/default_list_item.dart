import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

class DefaultListItem extends StatelessWidget {
  final ServingSize item;
  final void Function(ServingSize item) onPressed;

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
            Expanded(
              child: Row(
                children: [
                  const Icon(
                    Icons.check,
                    color: AppColors.greyMid,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      item.servingLabel,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            AutoSizeText(
              '${item.calories}',
              maxLines: 1,
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
