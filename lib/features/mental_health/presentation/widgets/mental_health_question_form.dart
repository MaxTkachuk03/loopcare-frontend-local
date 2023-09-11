import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_answer.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_option.dart';

class MentalHealthQuestionForm extends StatelessWidget {
  const MentalHealthQuestionForm({Key? key}) : super(key: key);

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
            Column(
              children: currentTest.options
                  .map(
                    (MentalHealthOption value) => Column(
                      children: [
                        AppChoiceChip(
                          label: value.title,
                          selected: currentAnswer?.optionId == value.id,
                          value: value.id,
                          textAlign: TextAlign.left,
                          chipHeight: 50.0,
                          onSelected: (int value) => _onSelected(value, currentQuestion.id, context),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  )
                  .toList(),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 45.0,
                ),
                ElevatedButton(
                  onPressed: currentAnswer != null ? () => _onNextPressed(context) : null,
                  child: const Text(LocalizedTexts.next).tr(),
                ),
                const SizedBox(
                  height: 25.0,
                ),
              ],
            )
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
  }

  void _onNextPressed(BuildContext context) {
    final isLastQuestion = context.read<MentalHealthBloc>().state.data.isLastQuestionInTest;

    context
      ..read<MentalHealthBloc>().add(const MentalHealthEvent.nextQuestion())
      ..read<MentalHealthBloc>().add(const MentalHealthEvent.nextPage());

    context.router.pushNamed(isLastQuestion ? AppRoutes.mentalCheckResult : AppRoutes.mentalHealthQuestion);
  }
}
