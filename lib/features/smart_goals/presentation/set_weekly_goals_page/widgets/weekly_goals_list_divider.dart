import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class WeeklyGoalsListDivider extends StatelessWidget {
  const WeeklyGoalsListDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: Divider(height: 1, color: AppColors.blueDarkest),
    );
  }
}
