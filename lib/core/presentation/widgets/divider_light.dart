import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class DividerLight extends StatelessWidget {
  const DividerLight({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.yellowLight,
      thickness: 1,
      height: 1,
    );
  }
}
