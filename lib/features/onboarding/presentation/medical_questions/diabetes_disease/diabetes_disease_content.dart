import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/diabetes_types.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/diabetes_disease/widgets/diabetes_chips.dart';

class DiabetesDiseaseContent extends StatefulWidget {
  const DiabetesDiseaseContent({super.key});

  @override
  State<DiabetesDiseaseContent> createState() => _DiabetesDiseaseContentState();
}

class _DiabetesDiseaseContentState extends State<DiabetesDiseaseContent> {
  final _diabetesListener = ValueNotifier<DiabetesTypes?>(null);

  @override
  void initState() {
    super.initState();
    final state = context.read<MedicalQuestionsBloc>().state;

    if (state.containsDiabetesTypeI) {
      _diabetesListener.value = DiabetesTypes.typeOne;
    } else if (state.containsDiabetesTypeII) {
      _diabetesListener.value = DiabetesTypes.typeTwo;
    } else if (state.containsDiabetesAnswer) {
      _diabetesListener.value = DiabetesTypes.no;
    }
  }

  @override
  void dispose() {
    _diabetesListener.dispose();
    super.dispose();
  }

  void _onSelected(DiabetesTypes value) => _diabetesListener.value = value;

  void _onNextPressed(DiabetesTypes value) {
    final bloc = context.read<MedicalQuestionsBloc>();

    final diseases = value == DiabetesTypes.typeTwo ? Diseases.diabetesTypeII : Diseases.diabetesTypeI;

    bloc.add(MedicalQuestionsEvent.updateDisease(diseases, value: value != DiabetesTypes.no));
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton.blueLightest(
      body: MainContainer(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 50.0),
            CustomText.bitter600(
              '${LocalizedTexts.diabetesQuestion.tr()}?',
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 36.0),
            DiabetesChips(
              initialValue: _diabetesListener.value,
              onChanged: _onSelected,
            ),
          ],
        ),
      ),
      button: ValueListenableBuilder<DiabetesTypes?>(
        valueListenable: _diabetesListener,
        builder: (context, value, _) {
          return CustomElevatedButton.coralFullWidth(
            label: LocalizedTexts.next.tr(),
            onPressed: value != null ? () => _onNextPressed(value) : null,
          );
        },
      ),
    );
  }
}
