import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/nutrition_tabs/nutrition_tabs.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/calorie_density/calorie_density.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/protein_degree/protein_degree.dart';

class NutritionValuePage extends StatefulWidget {
  const NutritionValuePage({Key? key}) : super(key: key);

  @override
  State<NutritionValuePage> createState() => _NutritionValuePageState();
}

class _NutritionValuePageState extends State<NutritionValuePage> {
  @override
  void initState() {
    context
        .read<NutritionBloc>()
        .add(const NutritionEvent.fetchValuesExplanation());

    super.initState();
  }

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
              children: const [
                NutritionTabs(
                  tabBarViewChildren: [
                    CalorieDensity(),
                    ProteinDegree(),
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
