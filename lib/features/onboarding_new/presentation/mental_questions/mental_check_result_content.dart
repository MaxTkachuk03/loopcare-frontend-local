import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/emergency_btn.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/mental_health_answer/mental_health_test.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/mental_health_answer/mental_health_test_type.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/mental_questions/widgets/gad7_result_text.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/mental_questions/widgets/phq15_result_text.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/mental_questions/widgets/phq8_result_text.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/mental_questions/widgets/who5_result_text.dart';
import 'package:url_launcher/url_launcher.dart';

class MentalCheckResultContent extends StatefulWidget {
  const MentalCheckResultContent({super.key});

  @override
  State<MentalCheckResultContent> createState() => _MentalCheckResultContentState();
}

class _MentalCheckResultContentState extends State<MentalCheckResultContent> {

  void onUrlHandler(BuildContext context) async {
    final Uri launchUri = Uri.parse(psychologistConsultingLink);

    try {
      await launchUrl(launchUri);
    } catch (e) {
      if (context.mounted) {
        _showError(context);
      }
    }
  }

  void _showError(BuildContext context) =>
      context.showError(content: CustomText.w400(LocalizedTexts.openLinkErrorMessage.tr()));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalQuestionsBloc, MentalQuestionsState>(
      builder: (context, state) {
        if (state.isLoading) return const Loader();

        final generalBloc = context.read<GeneralOnboardingBloc>();

        final currentTest = generalBloc.state.currentMentalTest;
        final error = state.error;

        if (currentTest == null) return const SizedBox.shrink();

        if (error != null) {
          return ErrorScreen(
            error: error,
            onButtonPressed: () => context.read<MentalQuestionsBloc>().add(
              MentalQuestionsEvent.getTestResults(
                test: currentTest,
              ),
            ),
          );
        }

        final resultText = _getResultTextWidget(currentTest);

        final subText = _getSubText(currentTest);

        return BottomPlacedButton.orange(
          body: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              UnderAppbar.orange(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: CustomText.bitter600(
                      _getTitleText(currentTest),
                      style: context.textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35.0),
              MainContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      decoration: const BoxDecoration(
                        color: AppColors.orangeLightest,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          resultText,
                          if (state.showEmergencyBtn(currentTest.type))
                            ...[
                              const SizedBox(height: 30.0),
                              const EmergencyBtn(),
                            ]
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    if (subText.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 30.0),
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        decoration: const BoxDecoration(
                          color: AppColors.orangeLightest,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: CustomText.w400(subText, style: context.textTheme.bodyMedium),
                      )
                  ],
                ),
              ),
            ],
          ),
          button: CustomElevatedButton.blueFullWidth(
            onPressed: () => _onNextPressed(context),
            label: LocalizedTexts.continueBtn.tr(),
          ),
        );
      },
    );
  }

  String _getSubText(MentalHealthTest test) {
    switch (test.type) {
      case MentalHealthTestType.who5:
        return '${LocalizedTexts.mentalResultSubText1.tr()}!';
      case MentalHealthTestType.phq15:
        return '${LocalizedTexts.mentalResultSubText2.tr()}!';
      case MentalHealthTestType.gad7:
        return '${LocalizedTexts.mentalResultSubText3.tr()}!';
      default:
        return '';
    }
  }

  String _getTitleText(MentalHealthTest test) {
    switch (test.type) {
      case MentalHealthTestType.who5:
        return LocalizedTexts.generalWellBeingSummary.tr();
      case MentalHealthTestType.phq15:
        return LocalizedTexts.bodyAndMindBalanceSummary.tr();
      case MentalHealthTestType.gad7:
      case MentalHealthTestType.phq8:
        return LocalizedTexts.stateOfMindSummary.tr();
      default:
        return '';
    }
  }

  _onNextPressed(BuildContext context) =>
      context.read<GeneralOnboardingBloc>().add(
        const GeneralOnboardingEvent.nextStep(),
      );

  Widget _getResultTextWidget(MentalHealthTest currentTest) => switch(currentTest.type) {
      MentalHealthTestType.who5 => WHO5ResultText(onLinkPressed: onUrlHandler),
      MentalHealthTestType.phq15 => PHQ15ResultText(onLinkPressed: onUrlHandler),
      MentalHealthTestType.gad7 => GAD7ResultText(onLinkPressed: onUrlHandler),
      MentalHealthTestType.phq8 => PHQ8ResultText(onLinkPressed: onUrlHandler),
    };
}
