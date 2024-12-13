import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/widgets/questions_chips.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class WeightLossMedicationContent extends StatefulWidget {
  const WeightLossMedicationContent({super.key});

  @override
  State<WeightLossMedicationContent> createState() => _WeightLossMedicationContentState();
}

class _WeightLossMedicationContentState extends State<WeightLossMedicationContent> {
  final _valueListener = ValueNotifier<bool?>(null);

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

  void _onSelected(bool value) => _valueListener.value = value;

  void _onNextPressed(bool value) {
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
    context
        .read<MedicalQuestionsBloc>()
        .add(MedicalQuestionsEvent.weightLossMedicationChanged(value));
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
              LocalizedTexts.onboardingWeightLossMedicationQuestion.tr(),
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 36.0),
            QuestionsChips(
              initialValue: _valueListener.value,
              onSelected: _onSelected,
            ),
          ],
        ),
      ),
      button: ValueListenableBuilder<bool?>(
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
