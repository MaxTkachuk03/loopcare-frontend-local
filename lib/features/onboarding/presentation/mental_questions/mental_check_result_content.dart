import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/emergency_btn.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test_type.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/widgets/gad7_result_text.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/widgets/phq15_result_text.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/widgets/phq8_result_text.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/widgets/who5_result_text.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:url_launcher/url_launcher.dart';

class MentalCheckResultContent extends StatefulWidget {
  const MentalCheckResultContent({super.key});

  @override
  State<MentalCheckResultContent> createState() => _MentalCheckResultContentState();
}

class _MentalCheckResultContentState extends State<MentalCheckResultContent> {
  void onUrlHandler(BuildContext context) async {
    final Uri launchUri = Uri.parse(LocalizedTexts.linksPsychologistConsulting.tr());

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
    return BlocConsumer<MentalQuestionsBloc, MentalQuestionsState>(
      listenWhen: (previous, current) => previous.isLoading && !current.isLoading,
      listener: _resultListener,
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

        final subText = currentTest.type.subTitle;

        return BottomPlacedButton.petrol(
          body: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              UnderAppbar.petrol(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: CustomText.bitter600(
                      currentTest.type.title,
                      style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
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
                        color: AppColors.petrolLightest,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          resultText,
                          if (state.showEmergencyBtn(currentTest.type)) ...[
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
                          color: AppColors.petrolLightest,
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

  _onNextPressed(BuildContext context) {
    final currentTest = context.read<GeneralOnboardingBloc>().state.currentMentalTest!;
    final isPhq8TestHigh = context.read<MentalQuestionsBloc>().state.isPhq8TestHigh;
    context.read<GeneralOnboardingBloc>().add(
          GeneralOnboardingEvent.nextStep(
              excluded: currentTest.type == MentalHealthTestType.phq8 && isPhq8TestHigh),
        );
  }

  Widget _getResultTextWidget(MentalHealthTest currentTest) => switch (currentTest.type) {
        MentalHealthTestType.who5 => WHO5ResultText(onLinkPressed: onUrlHandler),
        MentalHealthTestType.phq15 => PHQ15ResultText(onLinkPressed: onUrlHandler),
        MentalHealthTestType.gad7 => GAD7ResultText(onLinkPressed: onUrlHandler),
        MentalHealthTestType.phq8 => PHQ8ResultText(onLinkPressed: onUrlHandler),
      };

  void _resultListener(BuildContext context, MentalQuestionsState state) {
    final test = context.read<GeneralOnboardingBloc>().state.currentMentalTest;
    final result = state.results[test?.type];

    if (result != null) {
      const AnalyticsEventService().logEvent(
        eventName: AnalyticsEvents.userMentalHealthTest,
        parameters: {
          AnalyticsParameters.testType: test!.type.name,
          AnalyticsParameters.itemInterpretation: result.interpretation.name,
          AnalyticsParameters.totalScore: result.totalScore,
        },
      );

      CustomerIoService.track(
        event: CIOEvents.onboardingInterimResult,
        attributes: {
          CIOAttributes.testName: test.title,
          CIOAttributes.testScore: result.totalScore,
          CIOAttributes.interpretation: result.interpretation.name,
        },
      );
    }
  }
}
