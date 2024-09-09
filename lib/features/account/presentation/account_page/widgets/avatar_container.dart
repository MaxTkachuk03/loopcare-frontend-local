import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const _baseBorderSide =
    BorderSide(width: 2, color: AppColors.blueRegular, strokeAlign: BorderSide.strokeAlignOutside);

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({
    super.key,
    this.borderSide,
    this.radius,
    required this.child,
  });

  final BorderSide? borderSide;
  final double? radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(borderSide ?? _baseBorderSide),
      ),
      child: CircleAvatar(
        radius: radius ?? 75,
        child: child,
      ),
    );
  }
}
