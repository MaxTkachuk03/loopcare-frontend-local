import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/get_measurement_system.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_tabs.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/utils/weight_conversion_utils.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

const _kg = 'kg';
const _lbs = 'lbs';

class WeightContent extends StatefulWidget {
  const WeightContent({super.key});

  @override
  State<WeightContent> createState() => _WeightContentState();
}

class _WeightContentState extends State<WeightContent> {
  late TextEditingController kgController;
  late TextEditingController lbsController;
  final FocusNode kgFieldFocusNode = FocusNode();
  final FocusNode lbsFieldFocusNode = FocusNode();

  final ValueNotifier<bool> valueNotifier = ValueNotifier(false);

  MeasurementSystemType activeMeasurementType = getMeasurementSystem();

  @override
  void initState() {
    super.initState();
    final weightInKg = context.read<PhysicalQuestionsBloc>().state.weightInKg;

    kgController = TextEditingController(text: weightInKg ?? '');
    if (weightInKg != null) {
      lbsController = TextEditingController(
          text: '${WeightConversionUtils.convertKgToLbs(double.parse(weightInKg))}');
      valueNotifier.value = true;
    } else {
      lbsController = TextEditingController();
    }

    kgFieldFocusNode.requestFocus();
    lbsFieldFocusNode.requestFocus();
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
    return BottomPlacedButton.yellowLightest(
      body: MainContainer(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 80.0),
            CustomText.bitter600(
              LocalizedTexts.onboardingYourWeight.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 36.0),
            UnitTabs(
              tabBarViewChildren: [
                UnitField(
                  unit: _kg,
                  controller: kgController,
                  focusNode: kgFieldFocusNode,
                  maxLength: 3,
                  isDecimal: true,
                  counterText: '',
                  onChanged: validateInput,
                ),
                UnitField(
                  unit: _lbs,
                  isDecimal: true,
                  controller: lbsController,
                  focusNode: lbsFieldFocusNode,
                  maxLength: 3,
                  counterText: '',
                  onChanged: validateInput,
                ),
              ],
              onTabChanged: onTabChanged,
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
      button: ValueListenableBuilder<bool>(
        valueListenable: valueNotifier,
        builder: (context, enable, _) {
          return CustomElevatedButton.blueFullWidth(
            onPressed: enable ? onNextPressed : null,
            label: LocalizedTexts.next.tr(),
          );
        },
      ),
    );
  }

  void validateInput(value) => valueNotifier.value = value.isNotEmpty && value != '0';

  void onTabChanged(MeasurementSystemType unitType) {
    activeMeasurementType = unitType;
    if (!valueNotifier.value) {
      lbsController.clear();
      kgController.clear();
    }

    if (unitType == MeasurementSystemType.metric) {
      final lbsText = lbsController.text;
      if (lbsText.isEmpty) return;
      kgFieldFocusNode.requestFocus();
      kgController.text = '${WeightConversionUtils.convertLbsToKg(double.parse(lbsText))}';
    } else {
      final kgText = kgController.text;
      if (kgText.isEmpty) return;
      lbsFieldFocusNode.requestFocus();
      lbsController.text = '${WeightConversionUtils.convertKgToLbs(double.parse(kgText))}';
    }

    setState(() {});
  }

  String get weight =>
      activeMeasurementType == MeasurementSystemType.metric ? metricWeight : imperialWeight;

  String get metricWeight {
    final kgText = kgController.text.replaceAll(',', '.');
    if (kgText == '') return '';
    kgController.text = double.parse(kgText).toString();
    return kgController.text;
  }

  String get imperialWeight {
    final lbsText = lbsController.text.replaceAll(',', '.');
    if (lbsText == '') return '';
    lbsController.text = double.parse(lbsText).toString();
    return '${WeightConversionUtils.convertLbsToKg(double.parse(lbsText))}';
  }

  void onNextPressed() {
    kgFieldFocusNode.unfocus();
    lbsFieldFocusNode.unfocus();
    context.read<PhysicalQuestionsBloc>().add(
          PhysicalQuestionsEvent.weightChanged(
            weight: weight,
            measurementSystemType: activeMeasurementType,
          ),
        );

    final isValid = context.read<PhysicalQuestionsBloc>().state.validateBmi(weight);

    context.read<GeneralOnboardingBloc>().add(GeneralOnboardingEvent.nextStep(excluded: !isValid));
  }
}
