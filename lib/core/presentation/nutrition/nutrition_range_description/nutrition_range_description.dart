import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_indicator_color_picker.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_scale_breakpoints.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class NutritionRangeDescription extends StatelessWidget {
  final List<Range> scaleColorsList;
  final NutritionIndicatorType type;
  final List<num> numericDescription;

  const NutritionRangeDescription({
    super.key,
    required this.scaleColorsList,
    required this.type,
    required this.numericDescription,
  });

  factory NutritionRangeDescription.calorieDensity() => NutritionRangeDescription(
        scaleColorsList: NutritionIndicatorColorPicker.calorieDensityScaleValues,
        numericDescription: NutritionScaleBreakpoints.calorieDensityValues,
        type: NutritionIndicatorType.calorieDensity,
      );

  factory NutritionRangeDescription.proteinDegree() => NutritionRangeDescription(
        scaleColorsList: NutritionIndicatorColorPicker.proteinDegreeScaleValues.reversed.toList(),
        numericDescription: NutritionScaleBreakpoints.proteinDegreeValues,
        type: NutritionIndicatorType.proteinDegree,
      );

  factory NutritionRangeDescription.fiber() => NutritionRangeDescription(
        scaleColorsList: NutritionIndicatorColorPicker.carbFiberRatioValues,
        numericDescription: NutritionScaleBreakpoints.fiberValues,
        type: NutritionIndicatorType.fiber,
      );

  String _getLabel(num value) => switch (type) {
        NutritionIndicatorType.calorieDensity => '$value',
        NutritionIndicatorType.proteinDegree => '$value%',
        NutritionIndicatorType.fiber => '1:$value',
      };

  @override
  Widget build(BuildContext context) {
    final screenMiddle = MediaQuery.sizeOf(context).width / 2;

    return Column(
      children: [
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 3),
          itemCount: scaleColorsList.length,
          itemBuilder: (context, index) {
            final item = scaleColorsList[index];
            final leftValue = numericDescription.where((e) => item.min <= e && e < item.max);
            final hasValue = leftValue.isNotEmpty;

            return Stack(
              alignment: Alignment.center,
              children: [
                if (hasValue)
                  Positioned(
                    right: screenMiddle,
                    child: CustomText.w400(_getLabel(leftValue.first),
                        style: context.textTheme.bodySmall),
                  ),
                Center(
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: item.color,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
                Positioned(
                  left: screenMiddle,
                  child:
                      CustomText.w400(item.description ?? '', style: context.textTheme.bodySmall),
                ),
              ],
            );
          },
        ),
        if (type == NutritionIndicatorType.fiber)
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
                Positioned(
                  left: screenMiddle,
                  child: CustomText.w400(
                    LocalizedTexts.insignificant.tr(),
                    style: context.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
