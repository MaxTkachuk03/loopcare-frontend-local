import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/check_passed/widgets/passed_header.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/check_passed/widgets/physical_information.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';

class CheckPassedPage extends StatelessWidget {
  const CheckPassedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: MainContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 86,
                ),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    PhysicalInformation(
                      // TODO: add value from  bloc in the future
                      age: '47 years',
                      weight: '93 kg',
                      height: '181 cm',
                      bmi: '31',
                      verdict: LocalizedTexts.fitnessCheckPassedText.tr(),
                      moreInfoPressed: _onMoreInfoPressed,
                    ),
                    const PassedHeader(),
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: AppImages.checkMarkGreen,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: _onNextPressed,
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor:
                    MaterialStateProperty.all(AppColors.orangeDark),
                  ),
                  child: Text(
                    LocalizedTexts.continueBtn.tr(),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onNextPressed() {}

  void _onMoreInfoPressed() {}
}
