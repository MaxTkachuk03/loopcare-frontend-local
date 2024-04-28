import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/nutrition_indicator_color_picker.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/nutrition_indicator/nutrition_indicator.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class FiberDescription extends StatelessWidget {
  final double? fiberValue;
  final double? totalCarbs;
  final double? carbsFiberRatio;

  const FiberDescription({super.key, this.fiberValue, this.totalCarbs, this.carbsFiberRatio});

  get _isDisabled => fiberValue == 0;

  get _indicatorColor => _isDisabled
      ? AppColors.blueLightest
      : NutritionIndicatorColorPicker.getIndicatorColor(NutritionIndicatorType.fiber, fiberValue);

  get _indicatorLabel => _isDisabled ? '-' : '${fiberValue?.round()}%';

  // TODO add corrent lesson id, check back navigation from the lesson
  void _openLesson(BuildContext context) => context.router.pushNamed('/lesson/1/page/0');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: CustomText.bitter600(
            LocalizedTexts.fiber.tr(),
            style: context.textTheme.displayMedium,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  NutritionIndicator.big(label: _indicatorLabel, color: _indicatorColor),
                  CustomText.w400(
                    LocalizedTexts.fiberDailyGoal.tr(args: ['$fiberValue', '20']),
                    style: context.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText.w400(
                    LocalizedTexts.fiberDailyGoal.tr(args: ['$fiberValue', '20']),
                    style: context.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                  CustomText.w400(
                    LocalizedTexts.fiberRatioToCarbo.tr(args: ['$totalCarbs', '$carbsFiberRatio']),
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8.0),
            CustomText.w400(
              LocalizedTexts.fiberExplanation.tr(),
              style: context.textTheme.bodySmall,
            ),
            const SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                style: context.textTheme.bodySmall,
                children: [
                  TextSpan(text: '${LocalizedTexts.forMoreInformationSeeLesson.tr()} '),
                  TextSpan(
                    text: LocalizedTexts.carbohydratesPart2.tr(),
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
        ),
      ],
    );
  }
}
