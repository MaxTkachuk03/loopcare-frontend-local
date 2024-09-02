import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list_item.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_picker.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';

class HappinessContent extends StatefulWidget {
  const HappinessContent({super.key});

  @override
  State<HappinessContent> createState() => _HappinessContentState();
}

class _HappinessContentState extends State<HappinessContent> {
  late ValueNotifier<MoodPickerListItem?> _selectMood;

  @override
  void initState() {
    super.initState();

    _selectMood = ValueNotifier(null);
    final bloc = context.read<PhysicalQuestionsBloc>();
    if (bloc.state.happiness > 0) {
      _selectMood.value = moodPickerList.firstWhere((element) => element.value == bloc.state.happiness);
    }
  }

  @override
  void dispose() {
    _selectMood.dispose();
    super.dispose();
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
              LocalizedTexts.happinessTitle.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 30.0),
            CustomText.w400(
              '${LocalizedTexts.happinessBody1.tr()}.',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20.0),
            CustomText.w400(
              '${LocalizedTexts.happinessBody2.tr()}.',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 30.0),
            ValueListenableBuilder<MoodPickerListItem?>(
              valueListenable: _selectMood,
              builder: (context, mood, _) {
                return MoodPicker(
                  value: mood,
                  onItemPressed: (item) => _selectMood.value = item,
                );
              },
            )
          ],
        ),
      ),
      button: ValueListenableBuilder<MoodPickerListItem?>(
        valueListenable: _selectMood,
        builder: (context, mood, _) {
          final enable = mood != null;

          return CustomElevatedButton.blueFullWidth(
            onPressed: enable ? _onNextPressed : null,
            label: LocalizedTexts.next.tr(),
          );
        },
      ),
    );
  }

  void _onNextPressed() {
    context
        .read<PhysicalQuestionsBloc>()
        .add(PhysicalQuestionsEvent.happinessChanged(_selectMood.value!.value));
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }
}
