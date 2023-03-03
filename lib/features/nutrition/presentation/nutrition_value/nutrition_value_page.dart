import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/nutrition_tabs/nutrition_tabs.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/calorie_density/calorie_density.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/protein_degree/protein_degree.dart';

class NutritionValuePage extends StatelessWidget {
  const NutritionValuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO value will be get from the server
    final double _density = 2;
    final String _proteinDegree = '20 -25%';

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
                  tabBarViewChildren: [
                    CalorieDensity(density: _density),
                    ProteinDegree(proteinDegree: _proteinDegree),
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
