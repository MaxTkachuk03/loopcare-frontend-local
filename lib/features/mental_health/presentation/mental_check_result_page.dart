import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/emergency_btn.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_test_type.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_health_wrap.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/widgets/final_results_text.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/widgets/gad7_result_text.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/widgets/phq15_result_text.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/widgets/phq8_result_text.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/widgets/who5_result_text.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';

const psychologistConsultingLink = 'https://locator.apa.org/';

class MentalCheckResultPage extends StatefulWidget {
  final bool? calculationResultsNotNeeded;

  const MentalCheckResultPage({super.key, this.calculationResultsNotNeeded});

  @override
  State<MentalCheckResultPage> createState() => _MentalCheckResultPageState();
}

class _MentalCheckResultPageState extends State<MentalCheckResultPage> {
  @override
  void initState() {
    if (!(widget.calculationResultsNotNeeded ?? false)) {
      context.read<MentalHealthBloc>().add(const MentalHealthEvent.getTestResults());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MentalHealthWrap(
        child: CustomScaffold.orange(
          appBar: CustomAppBar.orange(
            title: LocalizedTexts.mentalHealth.tr(),
            leading: CustomFilledIconButton.leadingOrangeLighter(),
          ),
          body: SafeArea(
            child: ScrollableContainer(
              child: BlocBuilder<MentalHealthBloc, MentalHealthState>(
                builder: (context, state) {
                  if (state.data.isLoading) return const Loader();

                  final error = state.data.error;

                  if (error != null) {
                    return ErrorScreen(
                      error: error,
                      onButtonPressed: () => context.read<MentalHealthBloc>().add(
                            const MentalHealthEvent.getTestResults(),
                          ),
                    );
                  }

                  final currentTest = state.data.currentTest;
                  if (currentTest == null) return const SizedBox.shrink();

                  final isFinalResults = state.data.isLastTest && state.data.isCompleted;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ProgressBar.blue(backgroundColor: AppColors.orangeRegular),
                          UnderAppbar.orange(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText.bitter600(
                                      _getSuccessContainerTitle(),
                                      style: context.textTheme.displayMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 35.0),
                          MainContainer(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                  decoration: const BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      if (isFinalResults) const FinalResultsText(),
                                      if (currentTest.type == MentalHealthTestType.who5 && !isFinalResults)
                                        const WHO5ResultText(),
                                      if (currentTest.type == MentalHealthTestType.phq15 && !isFinalResults)
                                        const PHQ15ResultText(),
                                      if (currentTest.type == MentalHealthTestType.gad7 && !isFinalResults)
                                        const GAD7ResultText(),
                                      if (currentTest.type == MentalHealthTestType.phq8 && !isFinalResults)
                                        const PHQ8ResultText(),
                                      const SizedBox(height: 30.0),
                                      if (state.data.showEmergencyBtn) const EmergencyBtn()
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24.0),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                  decoration: const BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                  ),
                                  child: CustomText.w400(_subText(), style: context.textTheme.bodyMedium),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      MainContainer(
                        child: Column(
                          children: [
                            const SizedBox(height: 30.0),
                            CustomElevatedButton.blueFullWidth(
                              onPressed: () => _onNextPressed(context),
                              label: LocalizedTexts.continueBtn.tr(),
                            ),
                            const SizedBox(height: 30.0),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _subText() {
    final state = context.read<MentalHealthBloc>().state;
    final currentTest = state.data.currentTest;

    switch (currentTest?.type) {
      case MentalHealthTestType.who5:
        return '${LocalizedTexts.who5SubText.tr()}!';
      case MentalHealthTestType.phq15:
        return '${LocalizedTexts.phq15SubText.tr()}!';
      case MentalHealthTestType.gad7:
        return '${LocalizedTexts.gad75SubText.tr()}!';
      default:
        return '';
    }
  }

  String _getSuccessContainerTitle() {
    final state = context.read<MentalHealthBloc>().state;
    final currentTest = state.data.currentTest;
    final isFinalResults = state.data.isLastTest && state.data.isCompleted;

    if (isFinalResults) {
      return '${LocalizedTexts.mentalHealth.tr()}\n${LocalizedTexts.checkCompleted.tr()}';
    }

    switch (currentTest?.type) {
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

  _onNextPressed(BuildContext context) {
    final state = context.read<MentalHealthBloc>().state.data;

    if (!(state.isLastTest && state.isCompleted)) {
      context.read<MentalHealthBloc>().add(const MentalHealthEvent.nextPage());
    }

    if (state.isLastTest && !state.isCompleted) {
      context
        ..read<MentalHealthBloc>().add(const MentalHealthEvent.setCompleted(true))
        ..router.pushNamed(AppRoutes.mentalCheckResult);

      return;
    }

    if (state.isLastTest && state.isCompleted) {
      final hasCardiovascularDisease = context.read<MedicalFitnessBloc>().state.data.hasCardiovascularDisease;
      final nextRoute = hasCardiovascularDisease ? AppRoutes.consentConfirmation : AppRoutes.legalStatement;

      context
        ..read<OnboardingBloc>().add(const OnboardingEvent.nextStep())
        ..router.pushNamed(nextRoute);

      return;
    }

    context
      ..read<MentalHealthBloc>().add(const MentalHealthEvent.nextTest())
      ..router.pushNamed(AppRoutes.mentalHealthQuestion);
  }

  Future<bool> _onWillPop() {
    final bloc = context.read<MentalHealthBloc>();

    if (bloc.state.data.isLastTest && bloc.state.data.isCompleted) {
      bloc.add(const MentalHealthEvent.setCompleted(false));
    }

    return Future.value(true);
  }
}
