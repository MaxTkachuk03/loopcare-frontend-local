import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SectionItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final void Function()? onPressHandler;

  const SectionItem({
    Key? key,
    this.subTitle,
    required this.title,
    this.onPressHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressHandler,
      highlightColor: AppColors.greyLight.withOpacity(0.5),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ).tr(),
                if (subTitle != null)
                  Text(subTitle ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: ThemeConstants.fontSize14,
                            fontFamily: ThemeConstants.openSansFontFamily,
                            color: AppColors.greyLabel,
                          )).tr(),
              ],
            ),
          ),
          const IconButton(
            icon:  ImageIcon(
              AppIcons.arrow,
              color: AppColors.greyLabel,
            ), onPressed: null,
          ),
        ],
      ),
    );
  }
}
