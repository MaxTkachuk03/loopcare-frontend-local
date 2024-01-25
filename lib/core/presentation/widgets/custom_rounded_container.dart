import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomRoundedContainer extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final double? borderRadius;

  const CustomRoundedContainer({
    super.key,
    required this.child,
    this.bgColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
      ),
      child: child,
    );
  }
}
