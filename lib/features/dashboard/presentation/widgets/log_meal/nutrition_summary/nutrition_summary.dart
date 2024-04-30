import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/nutrition_summary/nutrition_scale.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

class NutritionSummary extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;
  final double? fiber;
  final double? carbFiberRatio;
  final double? carbsPercent;

  const NutritionSummary({
    super.key,
    this.calorieDensity,
    this.proteinDegree,
    this.fiber,
    this.carbFiberRatio,
    this.carbsPercent,
  });

  bool get _isFiberInsignificant => (carbsPercent ?? 0) < 20;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: NutritionScale.calorieDensity(value: calorieDensity)),
        Expanded(child: NutritionScale.proteinDegree(value: proteinDegree)),
        Expanded(
          child: NutritionScale.fiber(
            value: fiber,
            totalCarbs: context.read<MealsBloc>().state.selectedDayMealTotalCarbs,
            carbsFiberRatio: carbFiberRatio,
            isFiberInsignificant: _isFiberInsignificant,
          ),
        ),
      ],
    );
  }
}
