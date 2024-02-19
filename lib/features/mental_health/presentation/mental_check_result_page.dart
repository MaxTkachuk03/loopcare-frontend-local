import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/emergency_btn.dart';
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
import 'package:url_launcher/url_launcher.dart';

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

  void onUrlHandler(BuildContext context) async {
    final Uri launchUri = Uri.parse(psychologistConsultingLink);

    try {
      await launchUrl(launchUri);
    } catch (e) {
      _showError(context);
    }
  }

  void _showError(BuildContext context) =>
      context.showError(content: CustomText.w400(LocalizedTexts.openLinkErrorMessage.tr()));

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
                                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                                child: _getTitle(),
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
                                      if (isFinalResults) FinalResultsText(onLinkPressed: onUrlHandler),
                                      if (currentTest.type == MentalHealthTestType.who5 && !isFinalResults)
                                        WHO5ResultText(onLinkPressed: onUrlHandler),
                                      if (currentTest.type == MentalHealthTestType.phq15 && !isFinalResults)
                                        PHQ15ResultText(onLinkPressed: onUrlHandler),
                                      if (currentTest.type == MentalHealthTestType.gad7 && !isFinalResults)
                                        GAD7ResultText(onLinkPressed: onUrlHandler),
                                      if (currentTest.type == MentalHealthTestType.phq8 && !isFinalResults)
                                        PHQ8ResultText(onLinkPressed: onUrlHandler),
                                      if (state.data.showEmergencyBtn && !isFinalResults)
                                        const Column(children: [SizedBox(height: 30.0), EmergencyBtn()])
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24.0),
                                if (_subText.isNotEmpty)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                    decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(16)),
                                    ),
                                    child: CustomText.w400(_subText, style: context.textTheme.bodyMedium),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      isFinalResults && state.data.isPhq8TestHigh
                          ? const SizedBox.shrink()
                          : MainContainer(
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

  String get _subText {
    final state = context.read<MentalHealthBloc>().state;
    final currentTest = state.data.currentTest;

    switch (currentTest?.type) {
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

  String _getTitleText() {
    final state = context.read<MentalHealthBloc>().state;
    final currentTest = state.data.currentTest;
    final isFinalResults = state.data.isLastTest && state.data.isCompleted;
    final isPhq8High = state.data.isPhq8TestHigh;

    if (isFinalResults) {
      return isPhq8High
          ? LocalizedTexts.phq8Fail.tr()
          : '${LocalizedTexts.mentalHealth.tr()}\n${LocalizedTexts.checkCompleted.tr()}';
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

  Widget _getTitle() {
    final state = context.read<MentalHealthBloc>().state;
    final isFinalResults = state.data.isLastTest && state.data.isCompleted;
    final isPhq8High = state.data.isPhq8TestHigh;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isFinalResults && !isPhq8High)
          const CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.blueDarker,
            child: Icon(Icons.check, color: AppColors.white, size: 24),
          ),
        if (isFinalResults && !isPhq8High) const SizedBox(height: 22),
        CustomText.bitter600(
          _getTitleText(),
          style: context.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  _onNextPressed(BuildContext context) {
    final state = context.read<MentalHealthBloc>().state.data;

    if (!(state.isLastTest && state.isCompleted)) {
      context.read<MentalHealthBloc>().add(const MentalHealthEvent.nextPage());
    }

    if (state.isLastTest && !state.isCompleted) {
      context
        ..read<MentalHealthBloc>().add(const MentalHealthEvent.setCompleted(true))
        ..router.push(MentalCheckResultRoute(calculationResultsNotNeeded: true));

      return;
    }

    if (state.isLastTest && state.isCompleted) {
      context
        ..read<OnboardingBloc>().add(const OnboardingEvent.nextStep())
        ..router.pushNamed(AppRoutes.legalStatement);

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
