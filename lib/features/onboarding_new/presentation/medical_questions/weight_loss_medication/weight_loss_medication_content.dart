import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/weight_loss_medication_answers.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/weight_loss_medication/widgets/weight_loss_medication_chips.dart';

class WeightLossMedicationContent extends StatefulWidget {
  const WeightLossMedicationContent({super.key});

  @override
  State<WeightLossMedicationContent> createState() => _WeightLossMedicationContentState();
}

class _WeightLossMedicationContentState extends State<WeightLossMedicationContent> {
  final _valueListener = ValueNotifier<WeightLossMedicationAnswer?>(null);

  @override
  void initState() {
    super.initState();
    _valueListener.value = context.read<MedicalQuestionsBloc>().state.weightLossMedication;
  }

  @override
  void dispose() {
    _valueListener.dispose();
    super.dispose();
  }

  void _onSelected(WeightLossMedicationAnswer value) => _valueListener.value = value;

  void _onNextPressed(WeightLossMedicationAnswer value) {
    context.read<GeneralOnboardingBloc>().add(GeneralOnboardingEvent.nextStep(excluded: value.isUsed));
    context.read<MedicalQuestionsBloc>().add(MedicalQuestionsEvent.weightLossMedicationChanged(value));
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 50.0),
              CustomText.bitter600(
                '${LocalizedTexts.weightLossMedicationQuestion.tr()}?',
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 36.0),
              WeightLossMedicationChips(
                initialValue: _valueListener.value,
                onChanged: _onSelected,
              ),
            ],
          ),
          ValueListenableBuilder<WeightLossMedicationAnswer?>(
            valueListenable: _valueListener,
            builder: (context, value, _) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 42.0),
                child: CustomElevatedButton.coralFullWidth(
                  label: LocalizedTexts.next.tr(),
                  onPressed: value != null ? () => _onNextPressed(value) : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
