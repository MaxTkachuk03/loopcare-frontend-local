import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/input_formatters/serving_formatter.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/serving_input_field/serving_input_field.dart';

typedef OnValueChangesHandler = void Function(String val);

class ServingsAmount extends StatelessWidget {
  final TextEditingController inputController;
  final OnValueChangesHandler onValueChangeHandler;
  final FocusNode? focusNode;

  const ServingsAmount({
    super.key,
    required this.inputController,
    required this.onValueChangeHandler,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.greenLighter,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 15.0,
        ),
        child: Row(
          children: [
            ServingInputField(
              focusNode: focusNode,
              controller: inputController,
              fillColor: AppColors.white,
              onChange: onValueChangeHandler,
              inputFormatter: ServingRangeFormatter(),
            ),
            const SizedBox(width: 10),
            CustomText.w700(
              LocalizedTexts.serving.translation.capitalize(),
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
