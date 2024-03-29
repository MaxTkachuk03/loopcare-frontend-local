import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

const _defaultButtonPadding = EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 30.0);

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.contentPadding,
  });

  final Color backgroundColor;
  final Widget child;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: contentPadding ?? _defaultButtonPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            color: AppColors.black.withOpacity(0.12),
          ),
        ],
      ),
      child: child,
    );
  }
}
