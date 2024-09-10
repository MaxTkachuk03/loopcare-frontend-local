import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorDetails});

  String get _message =>
      kReleaseMode ? errorDetails.summary.toDescription() : errorDetails.summary.toString();

  final FlutterErrorDetails errorDetails;

  void _copyToClipBoard() async =>
      await Clipboard.setData(ClipboardData(text: errorDetails.toString()));

  void _resetDataAndNavigateToRoot(BuildContext context) {
    // Clean all data
    context
      ..read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.resetData())
      ..read<MedicalQuestionsBloc>().add(const MedicalQuestionsEvent.resetData())
      ..read<PhysicalQuestionsBloc>().add(const PhysicalQuestionsEvent.resetData())
      ..read<MentalQuestionsBloc>().add(const MentalQuestionsEvent.resetData())
      ..read<AuthenticationBloc>().add(const AuthenticationEvent.init())
      ..read<LegalStatementBloc>().add(const LegalStatementEvent.passageChanged(false));

    context.router.popUntilRoot();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
            color: AppColors.greyDarker, borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                kIsDev ? _message : 'Oops! Something went wrong!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kIsDev ? Colors.red : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              if (kIsDev)
                CustomElevatedButton.blueSmall(
                  label: 'Copy the error summary',
                  onPressed: _copyToClipBoard,
                )
              else
                const Text(
                  'Please close the application (swipe it away) and reopen it. Sorry for the inconvenience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              const SizedBox(height: 16),
              if (context.router.stack.map((e) => e.name).contains(IntroRoute.name))
                CustomElevatedButton.blue(
                  label: 'Back to Start',
                  onPressed: () => _resetDataAndNavigateToRoot(context),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
