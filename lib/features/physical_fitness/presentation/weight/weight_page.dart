import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/underlined_clickable_text.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/get_measurement_system.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_tabs.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/weight_conversion_utils.dart';

const kg = 'kg';
const lbs = 'lbs';

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  late TextEditingController kgController;
  late TextEditingController lbsController;
  late FocusNode kgFieldFocusNode;
  late FocusNode lbsFieldFocusNode;
  MeasurementSystemType activeMeasurementType = getMeasurementSystem();

  @override
  void initState() {
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
  void dispose() {
    kgController.dispose();
    lbsController.dispose();

    kgFieldFocusNode.dispose();
    lbsFieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: MainContainer(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Text(
              LocalizedTexts.yourWeight.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 48,
            ),
            UnitTabs(
              tabBarViewChildren: [
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
              onTabChanged: _onTabChanged,
            ),
            const SizedBox(
              height: 16.0,
            ),
            UnderlinedClickableText(
              text: LocalizedTexts.needHelpWithThis.tr(),
              onTap: _onHelpTap,
            ),
            const SizedBox(
              height: 20.0,
            ),
            _NextButton(
              measurementSystemType: activeMeasurementType,
              getWeight: getWeight,
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  void _onHelpTap() {}

  _onTabChanged(MeasurementSystemType unitType) {
    if (unitType == MeasurementSystemType.metric) {
      kgController.text = getMetricWeight();
      kgFieldFocusNode.requestFocus();
    } else {
      final kgText = kgController.text;
      if (kgText == '') return;
      lbsFieldFocusNode.requestFocus();
      lbsController.text =
          '${WeightConversionUtils.convertKgToLbs(double.parse(kgText))}';
    }

    setState(() {
      activeMeasurementType = unitType;
    });
  }

  String getWeight() {
    if (activeMeasurementType == MeasurementSystemType.metric) {
      return kgController.text;
    }

    return getMetricWeight();
  }

  String getMetricWeight() {
    final lbsText = lbsController.text;
    if (lbsText == '') return '';

    return '${WeightConversionUtils.convertLbsToKg(double.parse(lbsText))}';
  }
}

class _NextButton extends StatelessWidget {
  final MeasurementSystemType measurementSystemType;
  final String Function() getWeight;

  const _NextButton({
    Key? key,
    required this.measurementSystemType,
    required this.getWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onNextPressed(context),
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
          ),
      child: Text(
        LocalizedTexts.next.tr(),
      ),
    );
  }

  void _onNextPressed(BuildContext context) {
    final bloc = context.read<PhysicalFitnessBloc>();

    bloc.add(
      PhysicalFitnessEvent.weightChanged(
        weight: getWeight(),
        measurementSystemType: measurementSystemType,
      ),
    );

    final physicalFitnessNavigationState = StepNavigationState.of(context);

    physicalFitnessNavigationState.onNextPage();
  }
}
