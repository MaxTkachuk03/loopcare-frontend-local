import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/nutrition_tabs/nutrition_tabs.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/calorie_density/calorie_density.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/protein_degree/protein_degree.dart';

class NutritionInstructionsPage extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;
  final int tabIndex;

  const NutritionInstructionsPage({
    super.key,
    required this.tabIndex,
    this.calorieDensity,
    this.proteinDegree,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.greenLightest(
      appBar: CustomAppBar.green(
        title: LocalizedTexts.nutritionValues.translation,
      ),
      body: SafeArea(
        child: MainContainer(
          child: ScrollableContainer(
            child: NutritionTabs(
              initialIndex: tabIndex,
              tabBarViewChildren: [
                CalorieDensity(value: calorieDensity),
                ProteinDegree(value: proteinDegree),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
