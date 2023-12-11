import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

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
            color: AppColors.bgGreen,
            border: _getBorders(index, scaleSize ?? 9),
          ),
          child: Center(
            child: Text(
              label ?? '${index + 1}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadiusGeometry? _getBorderRadius(int index, int maxIndex) {
    if (index == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(5.0),
        bottomLeft: Radius.circular(5.0),
      );
    } else if (index == (maxIndex - 1)) {
      return const BorderRadius.only(
        topRight: Radius.circular(5.0),
        bottomRight: Radius.circular(5.0),
      );
    }

    return BorderRadius.zero;
  }

  BoxBorder _getBorders(int index, int maxIndex) {
    if (index == 0) {
      return Border(
        left: BorderSide(
          width: 3,
          color: borderColor ?? AppColors.yellowLight,
        ),
        right: BorderSide(
          width: 1,
          color: borderColor ?? AppColors.yellowLight,
        ),
        top: BorderSide(
          width: 3,
          color: borderColor ?? AppColors.yellowLight,
        ),
        bottom: BorderSide(
          width: 3,
          color: borderColor ?? AppColors.yellowLight,
        ),
      );
    } else if (index == (maxIndex - 1)) {
      return Border(
        left: BorderSide(
          width: 1,
          color: borderColor ?? AppColors.yellowLight,
        ),
        right: BorderSide(
          width: 3,
          color: borderColor ?? AppColors.yellowLight,
        ),
        top: BorderSide(
          width: 3,
          color: borderColor ?? AppColors.yellowLight,
        ),
        bottom: BorderSide(
          width: 3,
          color: borderColor ?? AppColors.yellowLight,
        ),
      );
    } else {
      return Border(
        left: BorderSide(
          width: 1,
          color: borderColor ?? AppColors.yellowLight,
        ),
        right: BorderSide(
          width: 1,
          color: borderColor ?? AppColors.yellowLight,
        ),
        top: BorderSide(
          width: 3,
          color: borderColor ?? AppColors.yellowLight,
        ),
        bottom: BorderSide(
          width: 3,
          color: borderColor ?? AppColors.yellowLight,
        ),
      );
    }
  }
}
