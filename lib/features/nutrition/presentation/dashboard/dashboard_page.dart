import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/nutrition_block/nutrition_block.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<NutritionInstructionsBloc>()
      ..add(const NutritionInstructionsEvent.fetchValuesExplanation())
      ..add(const NutritionInstructionsEvent.setCalorieDensity(2.0))
      ..add(const NutritionInstructionsEvent.setProteinDegree(50.0));

    super.initState();
  }

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
              children: const [
                NutritionBlock(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
