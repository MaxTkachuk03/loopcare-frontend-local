import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  final Color fillColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    required this.fillColor,
  });

  factory CustomCheckbox.blue({Function(bool?)? onChanged, bool value = false}) => CustomCheckbox(
        value: value,
        onChanged: onChanged,
        fillColor: AppColors.blueDarker,
      );

  factory CustomCheckbox.green({Function(bool?)? onChanged, bool value = false}) => CustomCheckbox(
        value: value,
        onChanged: onChanged,
        fillColor: AppColors.greenRegular,
      );

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };

        if (states.any(interactiveStates.contains)) {
          return fillColor;
        }
        return AppColors.transparent;
      }),
    );
  }
}
