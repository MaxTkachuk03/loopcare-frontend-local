import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

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
              Text(title).tr(),
              const ImageIcon(
                AppIcons.arrow,
                color: AppColors.greyLabel,
              ),
            ],
          ),
          Text(subTitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
        ],
      ),
    );
  }
}
