import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class MoodPickerRegularCell extends StatelessWidget {
  final Widget child;
  final bool isFirst;
  final bool isLast;
  final bool isOdd;

  const MoodPickerRegularCell({
    super.key,
    required this.child,
    required this.isFirst,
    required this.isLast,
    required this.isOdd,
  });

  BorderRadius _borderRadius() {
    double leftRadius = isFirst ? 8.0 : 0.0;
    double rightRadius = isLast ? 8.0 : 0.0;
    return BorderRadius.only(
      topLeft: Radius.circular(leftRadius),
      bottomLeft: Radius.circular(leftRadius),
      topRight: Radius.circular(rightRadius),
      bottomRight: Radius.circular(rightRadius),
    );
  }

  BoxBorder _border() {
    return Border(
      bottom: const BorderSide(width: 2, color: AppColors.orangeOffRegular),
      top: const BorderSide(width: 2, color: AppColors.orangeOffRegular),
      left: BorderSide(width: isOdd ? 0 : 2, color: AppColors.orangeOffRegular),
      right: BorderSide(width: isOdd ? 0 : 2, color: AppColors.orangeOffRegular),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: _border(),
        borderRadius: _borderRadius(),
      ),
      child: child,
    );
  }
}
