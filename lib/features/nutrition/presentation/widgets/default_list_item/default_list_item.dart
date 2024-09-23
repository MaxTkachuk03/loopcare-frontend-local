import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

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
            CustomText.w400(
              '${item.calories} ${LocalizedTexts.kcal.tr()}',
              maxLines: 1,
              style: context.textTheme.bodySmall?.copyWith(color: AppColors.greyRegular),
            ),
          ],
        ),
      ),
    );
  }
}
