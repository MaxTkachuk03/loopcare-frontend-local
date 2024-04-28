import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/nutrition_indicator_color_picker.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/nutrition_indicator/nutrition_indicator.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';

class ProteinDegreeDescription extends StatelessWidget {
  final double? proteinDegreeValue;

  const ProteinDegreeDescription({super.key, this.proteinDegreeValue});

  get _isDisabled => proteinDegreeValue == 0;

  get _indicatorColor => _isDisabled
      ? AppColors.blueLightest
      : NutritionIndicatorColorPicker.getIndicatorColor(
          NutritionIndicatorType.proteinDegree, proteinDegreeValue);

  get _indicatorLabel => _isDisabled ? '-' : '${proteinDegreeValue?.round()}%';

  // TODO add corrent lesson id, check back navigation from the lesson
  void _openLesson(BuildContext context) => context.router.pushNamed('/lesson/1/page/0');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: CustomText.bitter600(
            LocalizedTexts.proteinDegree.tr(),
            style: context.textTheme.displayMedium,
          ),
        ),
        BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
          builder: (BuildContext context, state) {
            return state.maybeMap(
              orElse: () => const SizedBox.shrink(),
              loaded: (state) {
                final proteinDegreeItem = state.data.getProteinDegreeItem(proteinDegreeValue);

                if (state.data.proteinDegreeValues.isEmpty || proteinDegreeItem == null) {
                  return const SizedBox();
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          NutritionIndicator.big(label: _indicatorLabel, color: _indicatorColor),
                          const SizedBox(height: 8.0),
                          CustomText.w600(
                            proteinDegreeItem.label.capitalize(),
                            style: context.textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: CustomText.w400(
                        proteinDegreeItem.text,
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(height: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8.0),
            CustomText.w400(
              LocalizedTexts.proteinDegreeExplanation.tr(),
              style: context.textTheme.bodySmall,
            ),
            const SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                style: context.textTheme.bodySmall,
                children: [
                  TextSpan(text: '${LocalizedTexts.forMoreInformationSeeLesson.tr()} '),
                  TextSpan(
                    text: LocalizedTexts.importanceOfProtein.tr(),
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
