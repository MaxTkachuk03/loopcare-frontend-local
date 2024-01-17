import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/toggle_button/toogle_switch.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class CustomToggleButton extends StatelessWidget {
  final List<String> children;
  final int? initialIndex;
  final Color selectedColor;
  final Color borderColor;
  final TextStyle? textStyle;
  final TextStyle? customActiveTextStyles;
  final Color? inactiveBgColor;
  final Function(int)? onTap;
  final List<double>? customWidths;

  const CustomToggleButton({
    super.key,
    required this.initialIndex,
    required this.children,
    required this.selectedColor,
    required this.borderColor,
    this.customActiveTextStyles,
    this.textStyle,
    this.onTap,
    this.inactiveBgColor,
    this.customWidths,
  });

  factory CustomToggleButton.coral({
    required List<String> children,
    required int? initialIndex,
    TextStyle? customActiveTextStyles,
    Color? inactiveBgColor,
    TextStyle? textStyle,
    List<double>? customWidths,
    Function(int)? onTap,
  }) =>
      CustomToggleButton(
        textStyle: textStyle,
        customActiveTextStyles: customActiveTextStyles,
        selectedColor: AppColors.coralRegular,
        borderColor: AppColors.coralRegular,
        onTap: onTap,
        initialIndex: initialIndex,
        inactiveBgColor: inactiveBgColor,
        customWidths: customWidths,
        children: children,
      );

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      customWidths: customWidths,
      multiLineText: true,
      customHeights: const [36.0],
      minHeight: 36.0,
      borderWidth: 2,
      borderColor: [borderColor],
      initialLabelIndex: initialIndex,
      cornerRadius: 50,
      activeFgColor: selectedColor,
      inactiveBgColor: inactiveBgColor ?? AppColors.white,
      inactiveFgColor: AppColors.transparent,
      totalSwitches: 2,
      radiusStyle: true,
      labels: children,
      activeBgColors: [
        [selectedColor],
        [selectedColor]
      ],
      customTextStyles: [
        context.textTheme.bodySmall,
        context.textTheme.bodySmall,
      ],
      customActiveTextStyles: customActiveTextStyles,
      centerText: true,
      onToggle: (index) => onTap?.call(index!),
    );
  }
}
