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
import 'package:loopcare_frontend/features/onboarding_new/domain/medication_future_period_answer.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/medication_future_period/widgets/medication_future_period_chips.dart';

class MedicationFuturePeriodContent extends StatefulWidget {
  const MedicationFuturePeriodContent({super.key});

  @override
  State<MedicationFuturePeriodContent> createState() => _MedicationFuturePeriodContentState();
}

class _MedicationFuturePeriodContentState extends State<MedicationFuturePeriodContent> {
  final _valueListener = ValueNotifier<MedicationFuturePeriodAnswer?>(null);

  @override
  void initState() {
    super.initState();
    _valueListener.value = context.read<MedicalQuestionsBloc>().state.howLongSemaglutideTreatmentLast;
  }

  @override
  void dispose() {
    _valueListener.dispose();
    super.dispose();
  }

  void _onSelected(MedicationFuturePeriodAnswer value) => _valueListener.value = value;

  void _onNextPressed(MedicationFuturePeriodAnswer value) {
    context.read<MedicalQuestionsBloc>().add(MedicalQuestionsEvent.medicationFuturePeriodChanged(value));
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 80.0),
              CustomText.bitter600(
                '${LocalizedTexts.medicationPastPeriodQuestion2.tr()}?',
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 36.0),
              MedicationFuturePeriodChips(
                initialValue: _valueListener.value,
                onChanged: _onSelected,
              ),
            ],
          ),
          ValueListenableBuilder(
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
