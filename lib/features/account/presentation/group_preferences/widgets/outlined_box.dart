import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class OutlinedBox extends StatelessWidget {
  final Widget child;

  const OutlinedBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        border: Border.all(width: 2, color: AppColors.yellowLight),
      ),
      child: child,
    );
  }
}
