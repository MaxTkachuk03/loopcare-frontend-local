import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class PassedHeader extends StatelessWidget {
  const PassedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        height: 138,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.greenLight,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 39,
                bottom: 25,
                left: 44,
                right: 44,
              ),
              child: Text(
                LocalizedTexts.fitnessCheckPassedTitle.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                      fontFamily: ThemeConstants.bitterFontFamily,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
