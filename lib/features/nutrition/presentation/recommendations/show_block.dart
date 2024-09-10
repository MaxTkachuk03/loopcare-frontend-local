import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ShowBlock extends StatelessWidget {
  final void Function() onPress;

  const ShowBlock({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              LocalizedTexts.show.tr(),
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 14.0, color: AppColors.blueDark),
            ),
          ),
          const SizedBox(
            width: 8,
            height: 16,
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
