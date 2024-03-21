import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/mental_questions/widgets/final_results_text.dart';
import 'package:url_launcher/url_launcher.dart';

class MentalCheckResultFinalContent extends StatefulWidget {
  const MentalCheckResultFinalContent({super.key});

  @override
  State<MentalCheckResultFinalContent> createState() => _MentalCheckResultFinalContentState();
}

class _MentalCheckResultFinalContentState extends State<MentalCheckResultFinalContent> {

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

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UnderAppbar.orange(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: _getTitle(state),
                    ),
                  ),
                ),
                const SizedBox(height: 35.0),
                MainContainer(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: const BoxDecoration(
                      color: AppColors.orangeLightest,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: FinalResultsText(onLinkPressed: onUrlHandler),
                  ),
                ),
              ],
            ),
            if (!state.isPhq8TestHigh)
            MainContainer(
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: CustomElevatedButton.blueFullWidth(
                      onPressed: () => _onNextPressed(context),
                      label: LocalizedTexts.continueBtn.tr(),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _getTitleText(bool isPhq8High) => isPhq8High
      ? LocalizedTexts.phq8Fail.tr()
      : '${LocalizedTexts.mentalHealth.tr()}\n${LocalizedTexts.checkCompleted.tr()}';

  Widget _getTitle(MentalQuestionsState state) {
    final isPhq8High = state.isPhq8TestHigh;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isPhq8High) ...[
          const CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.blueDarker,
            child: Icon(Icons.check, color: AppColors.white, size: 24),
          ),
          const SizedBox(height: 22),
        ],
        CustomText.bitter600(
          _getTitleText(isPhq8High),
          style: context.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.legalStatement);
  }
}
