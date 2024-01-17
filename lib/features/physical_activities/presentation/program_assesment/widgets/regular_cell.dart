import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class RegularCell extends StatelessWidget {
  final int index;
  final void Function(int tabIndex) onPress;
  final int? scaleSize;
  final String? label;
  final Color? borderColor;

  const RegularCell({
    super.key,
    required this.index,
    required this.onPress,
    this.scaleSize,
    this.label,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(index),
      child: ClipRRect(
        borderRadius: _getBorderRadius(index, scaleSize ?? 9),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            border: _getBorders(index, scaleSize ?? 9),
          ),
          child: Center(
            child: CustomText.w600(
              label ?? '${index + 1}',
              style: context.textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }

  BorderRadiusGeometry _getBorderRadius(int index, int maxIndex) {
    if (index == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        bottomLeft: Radius.circular(8.0),
      );
    } else if (index == (maxIndex - 1)) {
      return const BorderRadius.only(
        topRight: Radius.circular(8.0),
        bottomRight: Radius.circular(8.0),
      );
    }

    return BorderRadius.zero;
  }

  BoxBorder _getBorders(int index, int maxIndex) {
    if (index == 0) {
      return Border(
        left: BorderSide(width: 2, color: borderColor ?? AppColors.blueDarker),
        right: const BorderSide(width: 0.5, color: AppColors.blueLighter),
        top: BorderSide(width: 2, color: borderColor ?? AppColors.blueDarker),
        bottom: BorderSide(width: 2, color: borderColor ?? AppColors.blueDarker),
      );
    } else if (index == (maxIndex - 1)) {
      return Border(
        left: const BorderSide(width: 0.5, color: AppColors.blueLighter),
        right: BorderSide(width: 2, color: borderColor ?? AppColors.blueDarker),
        top: BorderSide(width: 2, color: borderColor ?? AppColors.blueDarker),
        bottom: BorderSide(width: 2, color: borderColor ?? AppColors.blueDarker),
      );
    } else {
      return Border(
        left: const BorderSide(width: 0.5, color: AppColors.blueLighter),
        right: const BorderSide(width: 0.5, color: AppColors.blueLighter),
        top: BorderSide(width: 2, color: borderColor ?? AppColors.blueDarker),
        bottom: BorderSide(width: 2, color: borderColor ?? AppColors.blueDarker),
      );
    }
  }
}
