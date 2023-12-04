import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AppUnlockBlock extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback? onBtnPressed;
  final String? btnText;

  const AppUnlockBlock({
    Key? key,
    required this.title,
    required this.text,
    this.onBtnPressed,
    this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(image: AppIcons.unlock),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ).tr(),
                const SizedBox(height: 4.0),
                Text(text),
                if (onBtnPressed != null) const SizedBox(height: 16.0),
                if (onBtnPressed != null)
                  SizedBox(
                    width: 120,
                    height: 34,
                    child: OutlinedButton(
                      onPressed: onBtnPressed,
                      child: Text(btnText ?? LocalizedTexts.start.translation),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
