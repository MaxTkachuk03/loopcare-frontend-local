import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/get_measurement_system.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_tabs.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/height/height.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/height/widgets/height_validator.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/physical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/height_conversion_utils.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

const cm = 'cm';
const ft = 'ft';
const inches = 'In';

class HeightPage extends StatefulWidget {
  const HeightPage({super.key});

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  late TextEditingController cmController;
  late TextEditingController ftController;
  late TextEditingController inController;
  final FocusNode cmFieldFocusNode = FocusNode();
  final FocusNode ftFieldFocusNode = FocusNode();
  MeasurementSystemType activeMeasurementType = getMeasurementSystem();
  int? heightInCm;
  int heightFT = 0;
  int heightIN = 0;

  @override
  void initState() {
    final bloc = context.read<PhysicalFitnessBloc>();
    if (bloc.state.heightInCm != null) {
      heightInCm = int.parse(bloc.state.heightInCm ?? "0");
      heightFT = HeightConversionUtils.convertCMtoFT(heightInCm ?? 0);
      heightIN = HeightConversionUtils.convertCMtoFtIn(heightInCm ?? 0);
      cmController = TextEditingController(text: heightInCm.toString());
      ftController = TextEditingController(text: heightFT.toString());
      inController = TextEditingController(text: heightIN.toString());
    } else {
      cmController = TextEditingController(text: '');
      ftController = TextEditingController(text: '');
      inController = TextEditingController(text: '');
    }

    super.initState();
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: CustomScaffold.yellowLightest(
        appBar: CustomAppBar.yellow(
          title: LocalizedTexts.physicalIntroTitle.tr(),
          leading: CustomFilledIconButton.leadingYellowLighter(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProgressBar.blue(backgroundColor: AppColors.yellowRegular),
                MainContainer(
                  child: Column(
                    children: [
                      CustomText.bitter600(
                        LocalizedTexts.yourHeight,
                        textAlign: TextAlign.center,
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 36.0),
                      UnitTabs(
                        tabBarViewChildren: [
                          UnitField(
                            unit: cm,
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
                                unit: ft,
                                controller: ftController,
                                focusNode: ftFieldFocusNode,
                                maxLength: Height.maxLengthImperial,
                                counterText: '',
                                onChanged: _setFT,
                              ),
                              const SizedBox(width: 12.0),
                              UnitField(
                                unit: inches,
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
                    ],
                  ),
                ),
                MainContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 52.0),
                      _NextButton(
                        measurementSystemType: activeMeasurementType,
                        getHeight: getHeight,
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setCM(String value) {
    if (value == '') value = "0";
    setState(() {
      heightInCm = int.parse(value);

      heightFT = HeightConversionUtils.convertCMtoFT(heightInCm ?? 0);
      heightIN = HeightConversionUtils.convertCMtoFtIn(heightInCm ?? 0);
    });
  }

  void _setFT(String value) {
    if (value == '') value = "0";
    setState(() {
      heightFT = int.parse(value);

      heightInCm = HeightConversionUtils.convertFeetAndInchesToCM(heightFT, heightIN);
    });
  }

  void _setIN(String value) {
    if (value == '') value = "0";
    setState(() {
      heightIN = int.parse(value);

      heightInCm = HeightConversionUtils.convertFeetAndInchesToCM(heightFT, heightIN);
    });
  }

  String getHeight() => heightInCm.toString();

  void _onTabChanged(MeasurementSystemType unitType) {
    setState(() {
      activeMeasurementType = unitType;
    });

    if (unitType == MeasurementSystemType.metric) {
      cmFieldFocusNode.requestFocus();
      if (heightInCm == null) return;
      cmController.text = heightInCm.toString();
    } else {
      ftFieldFocusNode.requestFocus();
      if (heightInCm == null) return;
      ftController.text = '${HeightConversionUtils.convertCMtoFT(heightInCm ?? 0)}';
      inController.text = '${HeightConversionUtils.convertCMtoFtIn(heightInCm ?? 0)}';
    }
  }
}

class _NextButton extends StatelessWidget {
  final MeasurementSystemType measurementSystemType;
  final String Function() getHeight;

  const _NextButton({
    required this.measurementSystemType,
    required this.getHeight,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.blueFullWidth(
      onPressed: () => _onNextPressed(context),
      label: LocalizedTexts.next,
    );
  }

  void _onNextPressed(BuildContext context) {
    final bloc = context.read<PhysicalFitnessBloc>();

    final validator = heightValidator();

    final validationMessage = validator!(getHeight());

    if (validationMessage != null) {
      ModalBottomSheet.physicalInvalidMessage(context: context, message: validationMessage);
    } else {
      bloc.add(
        PhysicalFitnessEvent.heightChanged(
          height: getHeight(),
          measurementSystemType: measurementSystemType,
        ),
      );

      final physicalFitnessNavigationState = StepNavigationState.of(context);

      physicalFitnessNavigationState.onNextPage();
    }
  }
}
