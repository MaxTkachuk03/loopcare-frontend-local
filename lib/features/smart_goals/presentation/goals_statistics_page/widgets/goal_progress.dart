import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class GoalProgress extends StatelessWidget {
  final double value;

  const GoalProgress({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(color: AppColors.greyLight, style: BorderStyle.solid),
          ),
        ),
        LinearProgressIndicator(
          minHeight: 8.0,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.orangeRegular),
          backgroundColor: AppColors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          value: value,
        ),
      ],
    );
  }
}
