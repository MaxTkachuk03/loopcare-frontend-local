import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_description_item.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_indicator_color_picker.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_values_description.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_indicator/nutrition_indicator.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_range_description/nutrition_range_description.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

final account = getIt<SharedStorageService>().account;

class FiberDescription extends StatelessWidget {
  final double? fiberValue;
  final double? totalCarbs;
  final double? carbsFiberRatio;
  final bool? isFiberInsignificant;

  const FiberDescription({
    super.key,
    this.fiberValue,
    this.totalCarbs,
    this.carbsFiberRatio,
    required this.isFiberInsignificant,
  });

  bool get _isDisabled => fiberValue == 0 || totalCarbs == 0;

  Color get _indicatorColor {
    if (_isDisabled) {
      return AppColors.blueLightest;
    } else if (isFiberInsignificant ?? false) {
      return AppColors.greyLight;
    } else {
      return NutritionIndicatorColorPicker.getIndicatorColor(
          NutritionIndicatorType.fiber, carbsFiberRatio);
    }
  }

  String get _indicatorLabel => _isDisabled ? '-' : '${fiberValue?.toStringAsFixed(1)}g';

  String get _fiberDailyGoal => '${account?.fiberDailyGoal}';

  String get _bottomLabel =>
      (isFiberInsignificant ?? false) ? LocalizedTexts.notSignificant.tr() : fiberItem.label.tr();

  void _openLesson(BuildContext context) {
    context
        .read<EducationLessonBloc>()
        .add(const EducationLessonEvent.getLessonContent(lessonId: 49));

    context.router.pushNamed('/lesson/49');
  }

  NutritionValueDescriptionItem get fiberItem =>
      NutritionValuesDescription.getFiberItemByValue(carbsFiberRatio ?? 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: CustomText.bitter600(
            LocalizedTexts.fiber.tr().capitalize(),
            style: context.textTheme.displayMedium,
            textAlign: TextAlign.center,
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
                  const SizedBox(height: 8),
                  CustomText.w600(
                    _bottomLabel,
                    style: context.textTheme.bodyMedium,
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
                    LocalizedTexts.fiberDailyGoal.tr({
                      'fiberAmount': '${fiberValue?.toStringAsFixed(1)}',
                      'dailyGoal': _fiberDailyGoal
                    }),
                    style: context.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                  CustomText.w400(
                    LocalizedTexts.fiberRatioToCarbo.tr({
                      'totalCarbohydrates': totalCarbs?.toStringAsFixed(0) ?? '',
                      'ratio': carbsFiberRatio?.toStringAsFixed(1) ?? ''
                    }),
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
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
        const SizedBox(height: 40.0),
        NutritionRangeDescription.fiber(),
      ],
    );
  }
}
