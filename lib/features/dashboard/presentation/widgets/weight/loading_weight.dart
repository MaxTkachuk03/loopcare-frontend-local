import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class LoadingWeight extends StatelessWidget {
  const LoadingWeight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizedTexts.logYourWeight.translation,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontFamily: ThemeConstants.bitterFontFamily,
                  color: AppColors.greyLabel,
                ),
          ),
          Text(
            LocalizedTexts.preferableInTheMorning.translation,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.greyLabel),
          )
        ],
      ),
    );
  }
}
