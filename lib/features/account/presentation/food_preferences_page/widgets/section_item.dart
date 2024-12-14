import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class SectionItem extends StatelessWidget {
  final String title;
  final List<String> options;
  final VoidCallback onPressHandler;

  const SectionItem({
    super.key,
    required this.title,
    required this.options,
    required this.onPressHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText.w400(
              title,
              style: context.textTheme.bodyMedium,
            ),
            IconButton(
              onPressed: onPressHandler,
              icon: const ImageIcon(
                AppIcons.arrow,
                color: AppColors.greyLabel,
              ),
            )
          ],
        ),
        Wrap(
          runSpacing: 4.0,
          spacing: 4.0,
          children: options
              .map(
                (o) => Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: AppColors.blueLighter,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: CustomText.w600(
                    o.capitalizeOnlyFirstLetter(),
                    style: context.textTheme.bodySmall,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
