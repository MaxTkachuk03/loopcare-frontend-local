import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_test_type.dart';

class QuestionText extends StatelessWidget {
  const QuestionText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalHealthBloc, MentalHealthState>(
      builder: (context, state) {
        final currentTest = state.data.currentTest;

        if (currentTest == null) return const SizedBox.shrink();

        if (currentTest.type == MentalHealthTestType.who5) {
          return RichText(
            text: TextSpan(
              text: LocalizedTexts.who8Question.translation,
              style: Theme.of(context).textTheme.bodyLarge,
              children: <TextSpan>[
                TextSpan(
                    text: ' ${LocalizedTexts.lastTwoWeeks.translation}.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          );
        }

        if (currentTest.type == MentalHealthTestType.phq15) {
          return RichText(
            text: TextSpan(
              text: LocalizedTexts.duringThe.translation,
              style: Theme.of(context).textTheme.bodyLarge,
              children: <TextSpan>[
                TextSpan(
                  text: ' ${LocalizedTexts.pastFourWeeks.translation}, ',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: LocalizedTexts.phq15Question.translation,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        if (currentTest.type == MentalHealthTestType.gad7) {
          return Text(
            LocalizedTexts.gad7Question,
            style: Theme.of(context).textTheme.bodyLarge,
          ).tr();
        }

        return RichText(
          text: TextSpan(
            text: LocalizedTexts.overThe.translation,
            style: Theme.of(context).textTheme.bodyLarge,
            children: <TextSpan>[
              TextSpan(
                text: ' ${LocalizedTexts.lastTwoWeeks.translation}, ',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: LocalizedTexts.phq8Question.translation,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        );
      },
    );
  }
}
