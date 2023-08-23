import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/success_container.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/medical_fitness/domain/cardiovascular_disease_answers.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_health_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

class MentalCheckResultPage extends StatelessWidget {
  const MentalCheckResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MentalHealthWrap(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 24.0),
              BlocBuilder<MentalHealthBloc, MentalHealthState>(
                builder: (context, state) {
                  return SuccessContainer(
                    withoutCheckMark: !state.data.isLastTest,
                    title: 'Partial Conclusion',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('test')],
                    ),
                  );
                },
              ),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () => _onNextPressed(context),
                child: const Text(LocalizedTexts.next).tr(),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ],
      ),
    );
  }

  _onNextPressed(BuildContext context) {
    final isLastTest = context.read<MentalHealthBloc>().state.data.isLastTest;

    if (isLastTest) {
      final cardiovascularDisease = context.read<MedicalFitnessBloc>().state.cardiovascularDisease;
      final nextRoute = cardiovascularDisease == CardiovascularDiseaseAnswers.noBut
          ? AppRoutes.consentConfirmation
          : AppRoutes.legalStatement;

      context
        ..read<OnboardingBloc>().add(const OnboardingEvent.nextStep())
        ..router.pushNamed(nextRoute);

      return;
    }

    context
      ..read<MentalHealthBloc>().add(const MentalHealthEvent.nextTest())
      ..router.pushNamed(AppRoutes.mentalHealthQuestion);
  }
}
