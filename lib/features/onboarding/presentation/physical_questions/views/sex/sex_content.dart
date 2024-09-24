import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/sex/widgets/sex_chips.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

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
    return BottomPlacedButton.yellowLightest(
      body: MainContainer(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 50.0),
            CustomText.bitter600(
              LocalizedTexts.onboardingWhatYourSex.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 36.0),
            CustomText.w400(
              LocalizedTexts.onboardingSexQuestionBody.tr(),
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 36.0),
            SexChips(
              initValue: _sexListener.value,
              onChanged: _onSelected,
            ),
          ],
        ),
      ),
      button: ValueListenableBuilder<SexType?>(
        valueListenable: _sexListener,
        builder: (context, sex, _) {
          return CustomElevatedButton.blueFullWidth(
            onPressed: sex != null ? () => _onNextPressed(sex) : null,
            label: LocalizedTexts.next.tr(),
          );
        },
      ),
    );
  }
}
