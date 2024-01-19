import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class TappedItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function() onPressHandler;

  const TappedItem({
    super.key,
    required this.subTitle,
    required this.title,
    required this.onPressHandler,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressHandler,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.w400(title, style: context.textTheme.bodyMedium),
              const ImageIcon(
                AppIcons.arrow,
                color: AppColors.greyLabel,
              ),
            ],
          ),
          CustomText.w600(subTitle, style: context.textTheme.bodySmall),
        ],
      ),
    );
  }
}
