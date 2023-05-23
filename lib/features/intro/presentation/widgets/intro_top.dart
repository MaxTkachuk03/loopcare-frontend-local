import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/intro/presentation/widgets/intro_item.dart';
import 'package:loopcare_frontend/injection.dart';

AppConfig appConfig = getIt<AppConfig>();

class IntroTop extends StatelessWidget {
  const IntroTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40.0,
        ),
        const Align(
          alignment: Alignment.center,
          child: Image(image: AppImages.logo),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: size.width * .75,
            child: Text(
              LocalizedTexts.introTitle
                  .tr(namedArgs: {'projectName': appConfig.projectName}),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontFamily: ThemeConstants.bitterFontFamily,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          height: 52,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              IntroItem(
                text: LocalizedTexts.introItemFirst.tr(),
                image: AppImages.introOne,
                color: AppColors.orangeLight,
              ),
              IntroItem(
                text: LocalizedTexts.introItemSecond.tr(),
                image: AppImages.introTwo,
                color: AppColors.blueLight,
              ),
              IntroItem(
                text: LocalizedTexts.introItemThird.tr(),
                image: AppImages.introThree,
                color: AppColors.greenLight,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
