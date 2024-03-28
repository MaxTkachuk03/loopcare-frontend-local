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
import 'package:loopcare_frontend/features/onboarding_new/presentation/widgets/questions_chips.dart';

class PregnancyContent extends StatefulWidget {
  const PregnancyContent({super.key});

  @override
  State<PregnancyContent> createState() => _PregnancyContentState();
}

class _PregnancyContentState extends State<PregnancyContent> {
  final _valueListener = ValueNotifier<bool?>(null);

  @override
  void initState() {
    super.initState();
    _valueListener.value = context.read<MedicalQuestionsBloc>().state.pregnancy;
  }

  @override
  void dispose() {
    _valueListener.dispose();
    super.dispose();
  }

  void _onSelected(bool value) => _valueListener.value = value;

  void _onPressedNext(bool value) {
    context.read<MedicalQuestionsBloc>().add(MedicalQuestionsEvent.pregnancyChanged(value));
    context.read<GeneralOnboardingBloc>().add(GeneralOnboardingEvent.nextStep(excluded: value));
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
                LocalizedTexts.areYouPregnant.tr(),
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 36.0),
              QuestionsChips(
                initialValue: context.read<MedicalQuestionsBloc>().state.pregnancy,
                onSelected: _onSelected,
              ),
            ],
          ),
          ValueListenableBuilder<bool?>(
            valueListenable: _valueListener,
            builder: (context, value, _) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 42.0),
                child: CustomElevatedButton.coralFullWidth(
                  label: LocalizedTexts.next.tr(),
                  onPressed: value != null ? () => _onPressedNext(value) : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
