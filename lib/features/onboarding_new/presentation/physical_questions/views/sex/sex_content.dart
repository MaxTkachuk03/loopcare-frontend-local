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
import 'package:loopcare_frontend/features/onboarding_new/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/sex/widgets/sex_chips.dart';

class SexContent extends StatefulWidget {
  const SexContent({super.key});

  @override
  State<SexContent> createState() => _SexContentState();
}

class _SexContentState extends State<SexContent> {
  final _sexListener = ValueNotifier<SexType?>(null);

  @override
  void initState() {
    super.initState();
    _sexListener.value = context.read<PhysicalQuestionsBloc>().state.sexType;
  }

  @override
  void dispose() {
    _sexListener.dispose();
    super.dispose();
  }

  void _onSelected(SexType value) => _sexListener.value = value;

  void _onNextPressed(SexType value) {
    context.read<PhysicalQuestionsBloc>().add(PhysicalQuestionsEvent.sexChanged(value));
    context.read<MedicalQuestionsBloc>().add(MedicalQuestionsEvent.handleSexType(value));
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
              const SizedBox(height: 80),
              CustomText.bitter600(
                '${LocalizedTexts.yourSex.tr()}?',
                textAlign: TextAlign.center,
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 36),
              CustomText.bitter600(
                '${LocalizedTexts.sexQuestionBody.tr()}.',
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 36),
              SexChips(
                initValue: _sexListener.value,
                onChanged: _onSelected,
              ),
            ],
          ),
          ValueListenableBuilder<SexType?>(
            valueListenable: _sexListener,
            builder: (context, sex, _) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 42.0),
                child: CustomElevatedButton.blueFullWidth(
                  onPressed: sex != null ? () => _onNextPressed(sex) : null,
                  label: LocalizedTexts.next.tr(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
