import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/calorie_tracker/calories_tracker.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class CalorieBudgetDescription extends StatelessWidget {
  final double totalCalories;

  const CalorieBudgetDescription({super.key, required this.totalCalories});

  void _openLesson(BuildContext context) {
    context
        .read<EducationLessonBloc>()
        .add(const EducationLessonEvent.getLessonContent(lessonId: 32));

    context.router.pushNamed('/lesson/32');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: CustomText.bitter600(
            LocalizedTexts.dailyCalorieBudget.tr(),
            style: context.textTheme.displayMedium,
          ),
        ),
        CaloriesTracker(totalCalories: totalCalories),
        const SizedBox(height: 20),
        CustomText.w400(
          LocalizedTexts.dailyCalorieBudgetDescription.tr(),
          style: context.textTheme.bodySmall,
        ),
        const SizedBox(height: 20.0),
        RichText(
          text: TextSpan(
            style: context.textTheme.bodySmall,
            children: [
              TextSpan(text: '${LocalizedTexts.forMoreInformationSeeLesson.tr()} '),
              TextSpan(
                text: LocalizedTexts.dailyCalorieBudgetLink.tr(),
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()..onTap = () => _openLesson(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
