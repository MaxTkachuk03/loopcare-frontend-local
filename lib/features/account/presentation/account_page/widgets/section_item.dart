import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SectionItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final void Function()? onPressHandler;
  final bool showNews;

  const SectionItem({
    super.key,
    this.subTitle,
    required this.title,
    this.onPressHandler,
    this.showNews = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressHandler,
      highlightColor: AppColors.greyLight.withOpacity(0.5),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.w400(
                    title,
                    style: context.textTheme.bodyMedium,
                  ),
                  if (subTitle != null && subTitle!.isNotEmpty)
                    CustomText.w600(
                      subTitle ?? '',
                      style: context.textTheme.bodySmall,
                    ),
                ],
              ),
            ),
            if (showNews) CategoryLabel.news(),
            const ImageIcon(
              AppIcons.arrow,
              color: AppColors.greyLabel,
            ),
          ],
        ),
      ),
    );
  }
}
