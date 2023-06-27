import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/success_container.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/medical_fitness/domain/cardiovascular_disease_answers.dart';
import 'package:loopcare_frontend/features/medical_fitness/domain/weight_loss_medication_answers.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

class MedicalCheckPassedPage extends StatelessWidget {
  const MedicalCheckPassedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MedicalQuestionWrap(
      child: MainContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 86),
                BlocBuilder<MedicalFitnessBloc, MedicalFitnessState>(
                  builder: (context, state) {
                    final text = state.weightLossMedication != WeightLossMedicationAnswer.no
                        ? LocalizedTexts.medicalCheckPassedDescriptionDetailed.tr()
                        : LocalizedTexts.medicalCheckPassedDescription.tr();

                    return SuccessContainer(
                      title: LocalizedTexts.medicalCheckPassedTitle.tr(),
                      content: Text(text),
                    );
                  },
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => _onContinuePressed(context),
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                      ),
                  child: Text(LocalizedTexts.continueBtn.tr()),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onContinuePressed(BuildContext context) {
    final cardiovascularDisease = context.read<MedicalFitnessBloc>().state.cardiovascularDisease;
    final nextRoute = cardiovascularDisease == CardiovascularDiseaseAnswers.noBut
        ? AppRoutes.consentConfirmation
        : AppRoutes.legalStatement;

    context
      ..read<OnboardingBloc>().add(const OnboardingEvent.nextStep())
      ..router.pushNamed(nextRoute);
  }
}
