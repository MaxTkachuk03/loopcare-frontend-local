import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/nutrition_tabs/nutrition_tabs.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/nutrition_value.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/calorie_density/calorie_density.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/protein_degree/protein_degree.dart';

class NutritionValuePage extends StatelessWidget {
  final double calorieDensity;
  final double proteinDegree;
  final NutritionValue currentCalorieDensityItem;
  final NutritionValue currentProteinDegreeItem;
  final int tabIndex;

  const NutritionValuePage({
    Key? key,
    required this.calorieDensity,
    required this.proteinDegree,
    required this.currentCalorieDensityItem,
    required this.currentProteinDegreeItem,
    required this.tabIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocalizedTexts.nutritionValues.translation,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              children: [
                NutritionTabs(
                  initialIndex: tabIndex,
                  tabBarViewChildren: [
                    CalorieDensity(
                      calorieDensity: calorieDensity,
                      currentCalorieDensityItem: currentCalorieDensityItem,
                    ),
                    ProteinDegree(
                      proteinDegree: proteinDegree,
                      currentProteinDegreeItem: currentProteinDegreeItem,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
