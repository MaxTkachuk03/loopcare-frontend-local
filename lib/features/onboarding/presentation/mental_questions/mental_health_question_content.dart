import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_answer.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_option.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/widgets/question_text.dart';

part 'widgets/_mental_health_choice_chips.dart';

class MentalHealthQuestionContent extends StatefulWidget {
  const MentalHealthQuestionContent({super.key});

  @override
  State<MentalHealthQuestionContent> createState() => _MentalHealthQuestionContentState();
}

class _MentalHealthQuestionContentState extends State<MentalHealthQuestionContent> {
  final _selectedOption = ValueNotifier<int?>(null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralOnboardingBloc, GeneralOnboardingState>(
      builder: (context, state) {
        final question = state.currentMentalQuestion;
        final test = state.currentMentalTest;

        return BottomPlacedButton.petrolLightest(
          body: MainContainer(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                const SizedBox(height: 50.0),
                QuestionText(currentTest: test),
                const SizedBox(height: 28.0),
                CustomText.bitter600(
                  question?.title ?? '',
                  style: context.textTheme.displayMedium,
                ),
                const SizedBox(height: 28.0),
                _MentalHealthChoiceChip(
                  onChanged: _onSelected,
                  options: test?.options ?? [],
                  questionId: question!.id,
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
          button: ValueListenableBuilder<int?>(
            valueListenable: _selectedOption,
            builder: (context, value, _) {
              return CustomElevatedButton.blueFullWidth(
                label: LocalizedTexts.next.tr(),
                onPressed: value != null ? () => _onNextPressed() : null,
              );
            }
          ),
        );
      }
    );
  }

  void _onSelected(int? value) {
    _selectedOption.value = value;
  }

  void _onNextPressed() {
    final state = context.read<GeneralOnboardingBloc>().state;

    context.read<MentalQuestionsBloc>().add(
      MentalQuestionsEvent.setAnswer(
        answer: MentalHealthAnswer(
          questionId: state.currentMentalQuestion!.id,
          optionId: _selectedOption.value!,
        ),
        testName: state.currentMentalTest?.title ?? '',
        question: state.currentMentalQuestion?.title ?? '',
        selectedOption: state.currentMentalTest?.options.firstWhere((o) => o.id == _selectedOption.value).title ?? '',
      ),
    );

    if (state.isLastMentalQuestion) {
      context.read<MentalQuestionsBloc>().add(
        MentalQuestionsEvent.getTestResults(
          test: state.currentMentalTest!,
        ),
      );
    }

    _selectedOption.value = null;

    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }
}
