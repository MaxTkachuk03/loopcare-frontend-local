import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SectionItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onPressHandler;

  const SectionItem({Key? key, required this.title, required this.subTitle, required this.onPressHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
              ).tr(),
              Text(subTitle, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
        IconButton(
          onPressed: onPressHandler,
          icon: const ImageIcon(
            AppIcons.arrow,
            color: AppColors.greyLabel,
          ),
        ),
      ],
    );
  }
}
