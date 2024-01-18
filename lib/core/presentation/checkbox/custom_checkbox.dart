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
      fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };

        if (states.any(interactiveStates.contains)) {
          return fillColor;
        }
        return AppColors.transparent;
      }),
    );
  }
}
