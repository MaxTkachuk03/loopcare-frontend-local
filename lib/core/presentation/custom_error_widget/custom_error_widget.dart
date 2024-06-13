import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/physical_questions/physical_questions_bloc.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorDetails});

  final FlutterErrorDetails errorDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kIsProd
                    ? 'Oops! Something went wrong!'
                    : errorDetails.summary.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kIsProd ? Colors.black : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              if (kIsProd)
                const Text(
                  'We encountered an error and we\'ve notified our engineering team about it. Sorry for the inconvenience caused.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                )
              else
                CustomOutlinedButton.greenSmall(
                  label: 'Copy the error summary',
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: errorDetails.toString()));
                  },
                ),
              const SizedBox(height: 16),
              CustomElevatedButton.green(
                label: 'Back home',
                onPressed: ()  {
                  if (context.router.stack.map((e) => e.name).contains(IntroRoute.name)) {
                    // Clean all data
                    context
                      ..read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.resetData())
                      ..read<MedicalQuestionsBloc>().add(const MedicalQuestionsEvent.resetData())
                      ..read<PhysicalQuestionsBloc>().add(const PhysicalQuestionsEvent.resetData())
                      ..read<MentalQuestionsBloc>().add(const MentalQuestionsEvent.resetData())
                      ..read<AuthenticationBloc>().add(const AuthenticationEvent.init())
                      ..read<LegalStatementBloc>().add(const LegalStatementEvent.passageChanged(false));
                  }

                  context.router.popUntilRoot();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
