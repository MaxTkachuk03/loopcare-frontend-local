import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SectionItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final void Function() onPressHandler;

  const SectionItem({
    Key? key,
    this.subTitle,
    required this.title,
    required this.onPressHandler,
  }) : super(key: key);

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
                style: Theme.of(context).textTheme.bodyMedium,
              ).tr(),
              if (subTitle != null)
                Text(subTitle ?? '',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyLabel,
                    )).tr(),
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
