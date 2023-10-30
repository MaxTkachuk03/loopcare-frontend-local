import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ShowBlock extends StatelessWidget {
  final void Function() onPress;

  const ShowBlock({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              LocalizedTexts.show.translation,
              style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.0, color: AppColors.blueDark),
            ),
          ),
          const SizedBox(
            width: 8,
            height: 12,
            child: ImageIcon(
              AppIcons.arrow,
              color: AppColors.blueDark,
            ),
          ),
        ],
      ),
    );
  }
}
