import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsentNeededPage extends StatelessWidget {
  const ConsentNeededPage({Key? key}) : super(key: key);

  final double hexagonSize = 65.0;

  @override
  Widget build(BuildContext context) {
    return MedicalQuestionWrap(
      isWithOnWillPop: false,
      child: MainContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 58.0,
                ),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: hexagonSize / 2),
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 44,
                          bottom: 58,
                          left: 40,
                          right: 36,
                        ),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              LocalizedTexts.needConsentBodyText1.tr(),
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              LocalizedTexts.needConsentBodyText2.tr(),
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                            ),
                            const SizedBox(
                              height: 36.0,
                            ),
                            ElevatedButton(
                              onPressed: _onDownloadInstructionsPressed,
                              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                    backgroundColor: MaterialStateProperty.all(AppColors.blueDark),
                                  ),
                              child: Text(
                                LocalizedTexts.downloadInstructions.tr(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Hexagon(
                        width: hexagonSize,
                        height: hexagonSize,
                        borderRadius: 15.0,
                        innerWidget: Container(
                          color: AppColors.blueDark,
                          child: AppImages.exclamationMark,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: const [
                _NextButton(),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDownloadInstructionsPressed() async {
    await launchUrl(
      Uri.parse('https://loopcare-pdf-instructions.s3.eu-central-1.amazonaws.com/Dokument2-2.pdf'),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onPressed(context),
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
          ),
      child: Text(
        LocalizedTexts.continueBtn.tr(),
      ),
    );
  }

  _onPressed(BuildContext context) {
    final medicalFitnessNavigationState = StepNavigationState.of(context);

    medicalFitnessNavigationState.onNextPage();
  }
}
