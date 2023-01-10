import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/small_filled_button.dart';

class FailedInformation extends StatelessWidget {
  final String? bmi;
  final String? informationsText;
  final String? adviceText;

  final void Function()? moreInfoPressed;

  const FailedInformation({
    Key? key,
    this.bmi,
    this.informationsText,
    this.adviceText,
    this.moreInfoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(
          top: 48,
          bottom: 25,
          left: 33,
          right: 33,
        ),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bmi != null) Text(LocalizedTexts.yourBodyMassIndex.tr()),
            if (bmi != null)
              Text(
                bmi!,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: AppColors.blueDark),
              ),
            if (bmi != null) const SizedBox(height: 26),
            if (informationsText != null)
              Text(
                informationsText!,
                style: Theme.of(context).textTheme.headline5,
              ),
            if (informationsText != null) const SizedBox(height: 26),
            if (adviceText != null) Text(adviceText!),
            if (adviceText != null) const SizedBox(height: 26),
            if (moreInfoPressed != null)
              SmallFilledButton(
                text: LocalizedTexts.moreInfo.tr(),
                onPressed: moreInfoPressed!,
              ),
          ],
        ),
      ),
    );
  }
}
