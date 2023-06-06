import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/serving_input_field/serving_input_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

typedef OnValueChangesHandler = void Function(String val);

class ServingsAmount extends StatelessWidget {
  final TextEditingController inputController;
  final OnValueChangesHandler onValueChangeHandler;
  final FocusNode? focusNode;

  const ServingsAmount({
    Key? key,
    required this.inputController,
    required this.onValueChangeHandler,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          ),
          const SizedBox(width: 10),
          Text(
            LocalizedTexts.serving.translation.capitalize(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
