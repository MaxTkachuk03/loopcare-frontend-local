import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/get_measurement_system.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_tabs.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/height/height.dart';
import 'package:loopcare_frontend/features/onboarding/domain/height_validator.dart';
import 'package:loopcare_frontend/features/onboarding/utils/height_conversion_utils.dart';

const _cm = 'cm';
const _ft = 'ft';
const _inches = 'In';

class HeightContent extends StatefulWidget {
  const HeightContent({super.key});

  @override
  State<HeightContent> createState() => _HeightContentState();
}

class _HeightContentState extends State<HeightContent> {
  late TextEditingController cmController;
  late TextEditingController ftController;
  late TextEditingController inController;

  final FocusNode cmFieldFocusNode = FocusNode();
  final FocusNode ftFieldFocusNode = FocusNode();

  final ValueNotifier<bool> valueNotifier = ValueNotifier(false);

  MeasurementSystemType activeMeasurementType = getMeasurementSystem();
  double? heightInCm;
  int heightFT = 0;
  int heightIN = 0;

  @override
  void initState() {
    super.initState();

    final bloc = context.read<PhysicalQuestionsBloc>();
    if (bloc.state.heightInCm != null) {
      heightInCm = double.parse(bloc.state.heightInCm ?? "0");
      heightFT = HeightConversionUtils.doubleConvertCMtoFT(heightInCm ?? 0).round();
      heightIN = HeightConversionUtils.doubleConvertCMtoFtIn(heightInCm ?? 0).round();
      cmController = TextEditingController(text: heightInCm.toString());
      ftController = TextEditingController(text: heightFT.toString());
      inController = TextEditingController(text: heightIN.toString());
      valueNotifier.value = true;
    } else {
      cmController = TextEditingController(text: '');
      ftController = TextEditingController(text: '');
      inController = TextEditingController(text: '');
    }

    cmFieldFocusNode.requestFocus();
    ftFieldFocusNode.requestFocus();
  }

  @override
  void dispose() {
    cmController.dispose();
    ftController.dispose();
    inController.dispose();

    cmFieldFocusNode.dispose();
    ftFieldFocusNode.dispose();

    valueNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton.yellowLightest(
      body: MainContainer(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 50.0),
            CustomText.bitter600(
              LocalizedTexts.yourHeight.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 36.0),
            UnitTabs(
              tabBarViewChildren: [
                UnitField(
                  unit: _cm,
                  controller: cmController,
                  isDecimal: true,
                  focusNode: cmFieldFocusNode,
                  maxLength: Height.maxLengthMetric,
                  counterText: '',
                  onChanged: _setCM,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UnitField(
                      unit: _ft,
                      controller: ftController,
                      focusNode: ftFieldFocusNode,
                      maxLength: Height.maxLengthImperial,
                      counterText: '',
                      onChanged: _setFT,
                    ),
                    const SizedBox(width: 12.0),
                    UnitField(
                      unit: _inches,
                      controller: inController,
                      maxLength: Height.maxLengthImperial,
                      counterText: '',
                      onChanged: _setIN,
                    ),
                  ],
                ),
              ],
              onTabChanged: _onTabChanged,
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
      button: ValueListenableBuilder<bool>(
        valueListenable: valueNotifier,
        builder: (context, enable, _) {
          return CustomElevatedButton.blueFullWidth(
            onPressed: enable ? _onNextPressed : null,
            label: LocalizedTexts.next.tr(),
          );
        },
      ),
    );
  }

  void _validateInput(value) => valueNotifier.value = value.isNotEmpty && value != '0';

  void _setCM(String value) {
    if (value == '') value = "0";
    setState(() {
      heightInCm = double.parse(value);

      heightFT = HeightConversionUtils.doubleConvertCMtoFT(heightInCm ?? 0).round();
      heightIN = HeightConversionUtils.doubleConvertCMtoFtIn(heightInCm ?? 0).round();
    });

    _validateInput(value);
  }

  void _setFT(String value) {
    if (value == '') value = "0";
    setState(() {
      heightFT = int.parse(value);

      heightInCm = HeightConversionUtils.doubleConvertFeetAndInchesToCM(
          heightFT.toDouble(), heightIN.toDouble());
    });

    _validateInput(value);
  }

  void _setIN(String value) {
    if (value == '') value = "0";
    setState(() {
      heightIN = int.parse(value);

      heightInCm = HeightConversionUtils.doubleConvertFeetAndInchesToCM(
          heightFT.toDouble(), heightIN.toDouble());
    });
  }

  String get height => heightInCm.toString();

  void _onTabChanged(MeasurementSystemType unitType) {
    setState(() {
      activeMeasurementType = unitType;
    });

    if (unitType == MeasurementSystemType.metric) {
      cmFieldFocusNode.requestFocus();
      if (heightInCm == null) return;
      var roundHeightInCm = heightInCm?.round();
      cmController.text = roundHeightInCm.toString();
    } else {
      ftFieldFocusNode.requestFocus();
      if (heightInCm == null) return;
      ftController.text = '${HeightConversionUtils.doubleConvertCMtoFT(heightInCm ?? 0).round()}';
      inController.text = '${HeightConversionUtils.doubleConvertCMtoFtIn(heightInCm ?? 0).round()}';
    }
  }

  void _onNextPressed() {
    final validator = heightValidator();

    final validationMessage = validator?.call(height);

    if (validationMessage != null) {
      ModalBottomSheet.physicalInvalidMessage(context: context, message: validationMessage);
    } else {
      context.read<PhysicalQuestionsBloc>().add(
            PhysicalQuestionsEvent.heightChanged(
              height: height,
              measurementSystemType: activeMeasurementType,
            ),
          );

      context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
    }
  }
}
