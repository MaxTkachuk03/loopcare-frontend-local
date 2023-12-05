import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class SectionItem extends StatelessWidget {
  final String title;
  final IList<String> options;
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
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
            ).tr(),
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
                    color: AppColors.bgGreen,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  child: Text(
                    o.capitalizeOnlyFirstLetter(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
