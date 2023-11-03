import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class MoodOptionItem extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final Widget subTitle;

  const MoodOptionItem({super.key, required this.onPressed, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      highlightColor: AppColors.greyLight.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyMedium).tr(),
                  const SizedBox(height: 10.0),
                  subTitle,
                ],
              ),
            ),
            const ImageIcon(AppIcons.arrow, color: AppColors.greyLabel),
          ],
        ),
      ),
    );
  }
}
