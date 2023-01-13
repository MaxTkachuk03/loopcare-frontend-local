import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_tabs.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/weight_conversion_utils.dart';

const kg = 'kg';
const lbs = 'lbs';

class WeightTabs extends StatefulWidget {
  const WeightTabs({Key? key}) : super(key: key);

  @override
  State<WeightTabs> createState() => _WeightTabsState();
}

class _WeightTabsState extends State<WeightTabs> {
  late TextEditingController kgController;
  late TextEditingController lbsController;

  @override
  void initState() {
    final bloc = context.read<PhysicalFitnessBloc>();
    kgController = TextEditingController(text: bloc.state.weight ?? '');
    lbsController = TextEditingController(text: bloc.state.weight ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UnitTabs(
      tabBarViewChildren: [
        UnitField(
          unit: kg,
          controller: kgController,
        ),
        UnitField(
          unit: lbs,
          controller: lbsController,
        ),
      ],
      onTabChanged: _onTabChanged,
    );
  }

  _onTabChanged(MeasurementSystemType unitType) {
    if (unitType == MeasurementSystemType.metric) {
      final lbsText = lbsController.text;
      if (lbsText == '') return;

      kgController.text =
          '${WeightConversionUtils.convertLbsToKg(double.parse(lbsText))}';
    } else {
      final kgText = kgController.text;
      if (kgText == '') return;

      lbsController.text =
          '${WeightConversionUtils.convertKgToLbs(double.parse(kgText))}';
    }
  }
}
