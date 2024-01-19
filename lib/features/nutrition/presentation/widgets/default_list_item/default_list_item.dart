import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

class DefaultListItem extends StatelessWidget {
  final ServingSize item;
  final void Function(ServingSize item) onPressed;

  const DefaultListItem({
    super.key,
    required this.item,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(item),
      child: Container(
        color: AppColors.greenLightest,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
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
                    color: AppColors.greyLight,
                  ),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: CustomText.w600(
                      item.servingLabel,
                      maxLines: 2,
                      style: context.textTheme.bodySmall?.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.greyRegular,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AutoSizeText(
              '${item.calories} ${LocalizedTexts.kcal.tr()}',
              maxLines: 1,
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.greyRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
