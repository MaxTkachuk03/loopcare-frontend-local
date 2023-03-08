import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/nutrition_value.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/nutrition_block/nutrition_block.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context
        .read<NutritionBloc>()
        .add(const NutritionEvent.fetchValuesExplanation());

    super.initState();
  }

  _calorieDensityFilter(int calorieDensity) => (NutritionValue el) {
        final double doubleMinValue = double.parse(el.minValue);
        final double doubleMaxValue = double.parse(el.maxValue);

        return doubleMinValue <= calorieDensity &&
            calorieDensity <= doubleMaxValue;
      };

  _proteinDegreeFilter(proteinDegree) => (NutritionValue el) {
        final double doubleMinValue = double.parse(el.minValue);
        final double doubleMaxValue = double.parse(el.maxValue);

        return doubleMinValue <= proteinDegree &&
            proteinDegree <= doubleMaxValue;
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
              child: Column(
            children: [
              BlocBuilder<NutritionBloc, NutritionState>(
                  builder: (BuildContext context, state) {
                if (state.calorieDensityValues.isEmpty ||
                    state.proteinDegreeValues.isEmpty) return const SizedBox();

                final NutritionValue currentCalorieDensityItem = state
                    .calorieDensityValues
                    .firstWhere(_calorieDensityFilter(2));

                final NutritionValue currentProteinDegreeItem = state
                    .proteinDegreeValues
                    .firstWhere(_proteinDegreeFilter(10));

                return NutritionBlock(
                  calorieDensityValue: 2,
                  proteinDegreeValue: 10,
                  currentCalorieDensityItem: currentCalorieDensityItem,
                  currentProteinDegreeItem: currentProteinDegreeItem,
                );
              }),
            ],
          )),
        ),
      ),
    );
  }
}
