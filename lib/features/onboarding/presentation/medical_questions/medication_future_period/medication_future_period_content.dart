import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/medication_future_period_answer.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/medication_future_period/widgets/medication_future_period_chips.dart';

@Deprecated('Not include in River Onboarding')
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
    return BottomPlacedButton.coralLightest(
      body: MainContainer(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 50.0),
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
      ),
      button: ValueListenableBuilder(
        valueListenable: _valueListener,
        builder: (context, value, _) {
          return CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.next.tr(),
            onPressed: value != null ? () => _onNextPressed(value) : null,
          );
        },
      ),
    );
  }
}
