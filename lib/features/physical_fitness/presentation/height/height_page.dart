import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
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
import 'package:loopcare_frontend/features/physical_fitness/domain/height/height.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/height/widgets/height_validator.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/height_conversion_utils.dart';

const cm = 'cm';
const ft = 'ft';
const inches = 'In';

class HeightPage extends StatefulWidget {
  const HeightPage({Key? key}) : super(key: key);

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  late TextEditingController cmController;
  late TextEditingController ftController;
  late TextEditingController inController;
  late FocusNode cmFieldFocusNode;
  late FocusNode ftFieldFocusNode;
  MeasurementSystemType activeMeasurementType = getMeasurementSystem();

  @override
  void initState() {
    final bloc = context.read<PhysicalFitnessBloc>();
    final heightInCm = bloc.state.heightInCm;
    cmController = TextEditingController(text: heightInCm ?? '');
    ftController = TextEditingController(
        text: heightInCm != null
            ? '${HeightConversionUtils.convertCMtoFeet(
                double.parse(heightInCm),
              )}'
            : '');
    inController = TextEditingController(
        text: heightInCm != null
            ? '${HeightConversionUtils.convertCMtoInches(
                double.parse(heightInCm),
              )}'
            : '');

    super.initState();
    cmFieldFocusNode = FocusNode();
    ftFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    cmController.dispose();
    ftController.dispose();
    inController.dispose();

    cmFieldFocusNode.dispose();
    ftFieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: MainContainer(
        child: Column(
          children: [
            const SizedBox(
              height: 70.0,
            ),
            Text(
              LocalizedTexts.yourHeight.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 48,
            ),
            UnitTabs(
              tabBarViewChildren: [
                UnitField(
                  unit: cm,
                  controller: cmController,
                  isDecimal: true,
                  focusNode: cmFieldFocusNode,
                  maxLength: Height.maxLengthMetric,
                  counterText: '',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UnitField(
                      unit: ft,
                      controller: ftController,
                      focusNode: ftFieldFocusNode,
                      maxLength: Height.maxLengthImperial,
                      counterText: '',
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    UnitField(
                      unit: inches,
                      controller: inController,
                      maxLength: Height.maxLengthImperial,
                      counterText: '',
                    ),
                  ],
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
                getHeight: getHeight),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  void _onHelpTap() {}

  String getHeight() {
    if (activeMeasurementType == MeasurementSystemType.metric) {
      return cmController.text;
    }

    return getMetricHeight();
  }

  void _onTabChanged(MeasurementSystemType unitType) {
    if (unitType == MeasurementSystemType.metric) {
      cmController.text = getMetricHeight();
      cmFieldFocusNode.requestFocus();
    } else {
      final cmText = cmController.text;
      if (cmText == '') return;
      ftFieldFocusNode.requestFocus();
      ftController.text = '${HeightConversionUtils.convertCMtoFeet(
        double.parse(cmText),
      )}';
      inController.text = '${HeightConversionUtils.convertCMtoInches(
        double.parse(cmText),
      )}';
    }

    setState(() {
      activeMeasurementType = unitType;
    });
  }

  String getMetricHeight() {
    final ftText = ftController.text;
    final inText = inController.text;
    if (ftText == '') return '';

    return '${HeightConversionUtils.convertFeetAndInchesToCM(
      double.parse(ftText),
      inText == '' ? 0 : double.parse(inText),
    )}';
  }
}

class _NextButton extends StatelessWidget {
  final MeasurementSystemType measurementSystemType;
  final String Function() getHeight;

  const _NextButton({
    Key? key,
    required this.measurementSystemType,
    required this.getHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onNextPressed(context),
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
          ),
      child: Text(LocalizedTexts.next.tr()),
    );
  }

  void _onNextPressed(BuildContext context) {
    final bloc = context.read<PhysicalFitnessBloc>();

    final validator = heightValidator();

    final validationMessage = validator!(getHeight());

    if (validationMessage != null) {
      ModalBottomSheet.physicalInvalidMessage(
        context: context,
        message: validationMessage,
        btnText: LocalizedTexts.changeYourHeight.tr(),
        onBtnPress: () => Navigator.pop(context),
      );
    } else {
      bloc.add(PhysicalFitnessEvent.heightChanged(
        height: getHeight(),
        measurementSystemType: measurementSystemType,
      ));

      final physicalFitnessNavigationState = StepNavigationState.of(context);

      physicalFitnessNavigationState.onNextPage();
    }
  }
}
