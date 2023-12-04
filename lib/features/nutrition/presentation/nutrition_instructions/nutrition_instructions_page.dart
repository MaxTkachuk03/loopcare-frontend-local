import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/nutrition_tabs/nutrition_tabs.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/calorie_density/calorie_density.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/protein_degree/protein_degree.dart';

class NutritionInstructionsPage extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;
  final int tabIndex;

  const NutritionInstructionsPage({
    Key? key,
    required this.tabIndex,
    this.calorieDensity,
    this.proteinDegree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocalizedTexts.nutritionValues.translation,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SafeArea(
        child: MainContainer(
          child: NutritionTabs(
            initialIndex: tabIndex,
            tabBarViewChildren: [
              CalorieDensity(value: calorieDensity),
              ProteinDegree(value: proteinDegree),
            ],
          ),
        ),
      ),
    );
  }
}
