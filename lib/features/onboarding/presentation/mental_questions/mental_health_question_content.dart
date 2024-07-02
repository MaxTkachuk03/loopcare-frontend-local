import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_answer.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/widgets/question_text.dart';

class MentalHealthQuestionContent extends StatelessWidget {
  const MentalHealthQuestionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralOnboardingBloc, GeneralOnboardingState>(
      builder: (context, state) {
        final currentQuestion = state.currentMentalQuestion;

        final currentTest = state.currentMentalTest;

        final currentAnswer = context.read<MentalQuestionsBloc>().state.answers
            .firstWhereOrNull((element) => element.questionId == currentQuestion?.id);

        return MainContainer(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(height: 50.0),
              QuestionText(currentTest: currentTest),
              const SizedBox(height: 28.0),
              CustomText.bitter600(
                currentQuestion?.title ?? '',
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 28.0),
              ...currentTest!.options.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomChoiceChip.petrol(
                    label: item.title,
                    selected: currentAnswer?.optionId == item.id,
                    onSelected: (value) => _onSelected(context, state, value),
                    value: item.id,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        );
      },
    );
  }

  void _onSelected(BuildContext context, GeneralOnboardingState state, int value) {
    context.read<MentalQuestionsBloc>().add(
      MentalQuestionsEvent.setAnswer(
        answer: MentalHealthAnswer(
          questionId: state.currentMentalQuestion!.id,
          optionId: value,
        ),
        testName: state.currentMentalTest?.title ?? '',
        question: state.currentMentalQuestion?.title ?? '',
        selectedOption: state.currentMentalTest?.options.firstWhere((o) => o.id == value).title ?? '',
      ),
    );

    if (state.isLastMentalQuestion) {
      context.read<MentalQuestionsBloc>().add(
        MentalQuestionsEvent.getTestResults(
          test: state.currentMentalTest!,
        ),
      );
    }

    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }
}
