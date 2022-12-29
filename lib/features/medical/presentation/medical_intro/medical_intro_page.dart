import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/medical/presentation/medical_intro/widgets/app_bar_sub_title.dart';
import 'package:loopcare_frontend/features/medical/presentation/medical_intro/widgets/bullet_list_item.dart';

class MedicalIntroPage extends StatelessWidget {
  const MedicalIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(LocalizedTexts.bodyAndMind.tr()),
            const AppBarSubTitle(),
          ],
        ),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      LocalizedTexts.checkYourMedicalCondition.tr(),
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            fontFamily: ThemeConstants.bitterFontFamily,
                          ),
                    ),
                    const SizedBox(
                      height: 21.0,
                    ),
                    Text(
                      LocalizedTexts.medicalIntroTitle.tr(),
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    BulletListItem(
                      bulletSize: 18.0,
                      text: Text(
                        LocalizedTexts.medicalIntroInstructionFirst.tr(),
                        style: const TextStyle(
                          fontSize: ThemeConstants.fontSize18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    BulletListItem(
                      bulletSize: 18.0,
                      text: Text(
                        LocalizedTexts.medicalIntroInstructionSecond.tr(),
                        style: const TextStyle(
                          fontSize: ThemeConstants.fontSize18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    BulletListItem(
                      bulletSize: 18.0,
                      text: Text(
                        LocalizedTexts.medicalIntroInstructionThird.tr(),
                        style: const TextStyle(
                          fontSize: ThemeConstants.fontSize18,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _onNextPressed,
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.orangeDark),
                      ),
                  child: Text(LocalizedTexts.next.tr()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onNextPressed() {}
}
