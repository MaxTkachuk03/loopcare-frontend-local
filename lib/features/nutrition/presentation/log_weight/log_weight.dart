import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/get_measurement_system.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_tabs.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/weight_conversion_utils.dart';

const kg = 'kg';
const lbs = 'lbs';

class LogWeight extends StatefulWidget {
  const LogWeight({Key? key}) : super(key: key);

  @override
  State<LogWeight> createState() => _LogWeightState();
}

class _LogWeightState extends State<LogWeight> {
  late TextEditingController kgController;
  late TextEditingController lbsController;
  late FocusNode kgFieldFocusNode;
  late FocusNode lbsFieldFocusNode;
  MeasurementSystemType activeMeasurementType = getMeasurementSystem();

  @override
  void initState() {
    print(activeMeasurementType);
    final bloc = context.read<PhysicalFitnessBloc>();
    final weightInKg = bloc.state.weightInKg;

    kgController = TextEditingController(text: weightInKg ?? '');
    lbsController = TextEditingController(
        text: weightInKg != null
            ? '${WeightConversionUtils.convertKgToLbs(double.parse(weightInKg))}'
            : '');

    kgFieldFocusNode = FocusNode();
    lbsFieldFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BlueAppBar(),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              children: [
                const SizedBox(height: 70),
                Text(
                  LocalizedTexts.yourWeight.translation,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 48),
                UnitField(
                  unit: kg,
                  controller: kgController,
                  focusNode: kgFieldFocusNode,
                  maxLength: 3,
                  counterText: '',
                ),
                UnitField(
                  unit: lbs,
                  controller: lbsController,
                  focusNode: lbsFieldFocusNode,
                  maxLength: 3,
                  counterText: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
