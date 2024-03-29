import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/widgets/questions_chips.dart';

class MedicalDiseaseContent extends StatefulWidget {
  const MedicalDiseaseContent(this. disease, {super.key});

  final Diseases disease;

  @override
  State<MedicalDiseaseContent> createState() => _MedicalDiseaseContentState();
}

class _MedicalDiseaseContentState extends State<MedicalDiseaseContent> {
  final _diseaseListener = ValueNotifier<bool?>(null);

  @override
  void initState() {
    super.initState();
    _diseaseListener.value = context.read<MedicalQuestionsBloc>().state.containsDisease(widget.disease);
  }

  @override
  void dispose() {
    _diseaseListener.dispose();
    super.dispose();
  }

  void _onSelected(bool value) {
    _diseaseListener.value = value;
  }

  void _onNextPressed(bool value) {
    context.read<MedicalQuestionsBloc>().add(MedicalQuestionsEvent.updateDisease(widget.disease, value: value));
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
              '${widget.disease.question.tr()}?',
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 36.0),
            QuestionsChips(
              initialValue: _diseaseListener.value,
              onSelected: _onSelected,
            ),
          ],
        ),
      ),
      button: ValueListenableBuilder<bool?>(
        valueListenable: _diseaseListener,
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
