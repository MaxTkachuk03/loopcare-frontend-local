import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
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
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  late TextEditingController kgController;
  late TextEditingController lbsController;
  final FocusNode kgFieldFocusNode = FocusNode();
  final FocusNode lbsFieldFocusNode = FocusNode();
  final ValueNotifier<bool> valueNotifier = ValueNotifier(false);
  MeasurementSystemType activeMeasurementType = getMeasurementSystem();

  @override
  void initState() {
    final bloc = context.read<PhysicalFitnessBloc>();
    final weightInKg = bloc.state.weightInKg;
    kgController = TextEditingController(text: weightInKg ?? '');
    lbsController = TextEditingController(
        text: weightInKg != null ? '${WeightConversionUtils.convertKgToLbs(double.parse(weightInKg))}' : '');
    kgFieldFocusNode.requestFocus();
    lbsFieldFocusNode.requestFocus();

    super.initState();
  }

  @override
  void dispose() {
    kgController.dispose();
    lbsController.dispose();
    valueNotifier.dispose();
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
            const SizedBox(height: 80.0),
            CustomText.bitter600(
              LocalizedTexts.yourWeight.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 36.0),
            UnitTabs(
              tabBarViewChildren: [
                UnitField(
                  unit: kg,
                  controller: kgController,
                  focusNode: kgFieldFocusNode,
                  maxLength: 3,
                  isDecimal: true,
                  counterText: '',
                  onChanged: validateInput,
                ),
                UnitField(
                  unit: lbs,
                  isDecimal: true,
                  controller: lbsController,
                  focusNode: lbsFieldFocusNode,
                  maxLength: 3,
                  counterText: '',
                  onChanged: validateInput,
                ),
              ],
              onTabChanged: _onTabChanged,
            ),
            const SizedBox(height: 52.0),
            ValueListenableBuilder<bool>(
              valueListenable: valueNotifier,
              builder: (context, enable, _) {
                return _NextButton(
                  measurementSystemType: activeMeasurementType,
                  getWeight: getWeight,
                  enable: enable,
                );
              },
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  void validateInput(value) => valueNotifier.value = value.isNotEmpty && value != '0';

  _onTabChanged(MeasurementSystemType unitType) {
    setState(() {
      activeMeasurementType = unitType;
      if (!valueNotifier.value) {
        lbsController.clear();
        kgController.clear();
      }
    });

    if (unitType == MeasurementSystemType.metric) {
      kgController.text = getMetricWeight();
      kgFieldFocusNode.requestFocus();
    } else {
      final kgText = kgController.text;
      if (kgText == '') return;
      lbsFieldFocusNode.requestFocus();
      lbsController.text = '${WeightConversionUtils.convertKgToLbs(double.parse(kgText))}';
    }
  }

  String getWeight() {
    if (activeMeasurementType == MeasurementSystemType.metric) {
      final kgText = kgController.text.replaceAll(',', '.');
      if (kgText == '') return '';
      kgController.text = double.parse(kgText).toString();
      return kgController.text;
    }
    return getMetricWeight();
  }

  String getMetricWeight() {
    final lbsText = lbsController.text.replaceAll(',', '.');
    if (lbsText == '') return '';
    lbsController.text = double.parse(lbsText).toString();
    return '${WeightConversionUtils.convertLbsToKg(double.parse(lbsText))}';
  }
}

class _NextButton extends StatelessWidget {
  final MeasurementSystemType measurementSystemType;
  final String Function() getWeight;
  final bool enable;

  const _NextButton({
    required this.measurementSystemType,
    required this.getWeight,
    required this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.blueFullWidth(
      onPressed: enable ? () => _onNextPressed(context) : null,
      label: LocalizedTexts.next,
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
