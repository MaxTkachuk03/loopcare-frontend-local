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
import 'package:loopcare_frontend/features/onboarding_new/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/gender/widgets/gender_chips.dart';

class GenderContent extends StatefulWidget {
  const GenderContent({super.key});

  @override
  State<GenderContent> createState() => _GenderContentState();
}

class _GenderContentState extends State<GenderContent> {
  final _genderListener = ValueNotifier<GenderType?>(null);

  @override
  void initState() {
    super.initState();
    _genderListener.value = context.read<PhysicalQuestionsBloc>().state.genderType;
  }

  @override
  void dispose() {
    _genderListener.dispose();
    super.dispose();
  }

  void _onSelected(GenderType gender) {
    _genderListener.value = gender;
  }

  void _onNextPressed(GenderType gender) {
    context.read<PhysicalQuestionsBloc>().add(PhysicalQuestionsEvent.genderChanged(gender));
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
              '${LocalizedTexts.genderPageTitle.tr()}?',
              textAlign: TextAlign.center,
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 36.0),
            GenderChips(
              initValue: _genderListener.value,
              onChanged: _onSelected,
            ),
          ],
        ),
      ),
      button: ValueListenableBuilder<GenderType?>(
        valueListenable: _genderListener,
        builder: (context, gender, _) {
          return CustomElevatedButton.blueFullWidth(
            onPressed: gender != null ? () => _onNextPressed(gender) : null,
            label: LocalizedTexts.next.tr(),
          );
        },
      ),
    );
  }
}
