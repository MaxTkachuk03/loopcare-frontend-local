import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

const _kRegularHeight = 50.0;

class RegularCell extends StatelessWidget {
  final int index;
  final void Function(int tabIndex) onPress;
  final int? scaleSize;
  final String? label;
  final Color? borderColor;
  final Color? divColor;
  final Color? textColor;

  const RegularCell({
    super.key,
    required this.index,
    required this.onPress,
    this.scaleSize,
    this.label,
    this.borderColor,
    this.divColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(index),
      child: Container(
        height: _kRegularHeight,
        width: 40,
        decoration: BoxDecoration(
          border: _getBorders(index, scaleSize ?? 9),
          borderRadius: _getBorderRadius(index, scaleSize ?? 9),
        ),
        child: Center(
          child: CustomText.w600(
            label ?? '${index + 1}',
            style: context.textTheme.bodyMedium?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }

  BorderRadiusGeometry _getBorderRadius(int index, int maxIndex) {
    if (index == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(10.0),
        bottomLeft: Radius.circular(10.0),
      );
    } else if (index == (maxIndex - 1)) {
      return const BorderRadius.only(
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      );
    }
    return BorderRadius.zero;
  }

  BoxBorder _getBorders(int index, int maxIndex) {
    if (index == 0) {
      return Border(
        left: BorderSide(
          width: 2,
          color: borderColor ?? AppColors.yellowLight,
        ),
        top: BorderSide(
          width: 2,
          color: borderColor ?? AppColors.yellowLight,
        ),
        bottom: BorderSide(
          width: 2,
          color: borderColor ?? AppColors.yellowLight,
        ),
      );
    } else if (index == (maxIndex - 1)) {
      return Border(
        right: BorderSide(
          width: 2,
          color: borderColor ?? AppColors.yellowLight,
        ),
        top: BorderSide(
          width: 2,
          color: borderColor ?? AppColors.yellowLight,
        ),
        bottom: BorderSide(
          width: 2,
          color: borderColor ?? AppColors.yellowLight,
        ),
      );
    } else {
      return Border(
        left: BorderSide(
          width: 0.5,
          color: divColor ?? AppColors.yellowLight,
        ),
        right: BorderSide(
          width: 0.5,
          color: divColor ?? AppColors.yellowLight,
        ),
        top: BorderSide(
          width: 2,
          color: borderColor ?? AppColors.yellowLight,
        ),
        bottom: BorderSide(
          width: 2,
          color: borderColor ?? AppColors.yellowLight,
        ),
      );
    }
  }
}
