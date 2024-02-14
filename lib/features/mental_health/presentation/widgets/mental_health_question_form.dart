import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_answer.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_option.dart';

class MentalHealthQuestionForm extends StatelessWidget {
  const MentalHealthQuestionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalHealthBloc, MentalHealthState>(
      builder: (context, state) {
        final currentTest = state.data.currentTest;
        final currentQuestion = state.data.currentQuestion;

        if (currentTest == null || currentQuestion == null) return const SizedBox.shrink();

        final currentAnswer =
            state.data.answers.firstWhereOrNull((element) => element.questionId == currentQuestion.id);

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i) {
                final MentalHealthOption value = currentTest.options[i];

                return CustomChoiceChip.orange(
                  label: value.title,
                  selected: currentAnswer?.optionId == value.id,
                  onSelected: (int value) => _onSelected(value, currentQuestion.id, context),
                  value: value.id,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8.0),
              itemCount: currentTest.options.length,
            ),
          ],
        );
      },
    );
  }

  void _onSelected(int value, int currentQuestionId, BuildContext context) {
    context.read<MentalHealthBloc>().add(
          MentalHealthEvent.setAnswer(
            MentalHealthAnswer(
              questionId: currentQuestionId,
              optionId: value,
            ),
          ),
        );

    final isLastQuestion = context.read<MentalHealthBloc>().state.data.isLastQuestionInTest;

    context
      ..read<MentalHealthBloc>().add(const MentalHealthEvent.nextQuestion())
      ..read<MentalHealthBloc>().add(const MentalHealthEvent.nextPage());

    context.router.pushNamed(isLastQuestion ? AppRoutes.mentalCheckResult : AppRoutes.mentalHealthQuestion);
  }
}
