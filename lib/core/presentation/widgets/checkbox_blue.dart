import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CheckboxBlue extends StatelessWidget {
  final bool value;
  final void Function(bool?) onChanged;

  const CheckboxBlue({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      checkColor: AppColors.white,
      activeColor: AppColors.blueDark,
      side: const BorderSide(width: 1.0, color: AppColors.yellowLight),
      value: value,
      onChanged: onChanged,
    );
  }
}
