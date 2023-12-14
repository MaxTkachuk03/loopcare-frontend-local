import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/orange_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/get_measurement_system.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_field.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/weight_conversion_utils.dart';

class LogWeightPage extends StatefulWidget {
  final DateTime selectedDay;

  const LogWeightPage({
    super.key,
    required this.selectedDay,
  });

  @override
  State<LogWeightPage> createState() => _LogWeightPageState();
}

class _LogWeightPageState extends State<LogWeightPage> {
  late TextEditingController weightFieldController;
  late TextEditingController lbsController;
  final FocusNode fieldFocusNode = FocusNode();

  final bool _isMetricSystem = getMeasurementSystem() == MeasurementSystemType.metric;

  @override
  void initState() {
    weightFieldController = TextEditingController(text: _getInputInitialValue());
    fieldFocusNode.requestFocus();
    super.initState();
  }

  String _getInputInitialValue() {
    final state = context.read<DashboardWeightBloc>().state;

    double? selectedDayWeightValue = state.data.getSelectedDayWeight(widget.selectedDay.isoStringWithoutTime);

    if (selectedDayWeightValue == null) return '';

    String inputValue = _isMetricSystem
        ? selectedDayWeightValue.toString()
        : WeightConversionUtils.convertKgToLbs(selectedDayWeightValue).toString();

    return inputValue;
  }

  @override
  void dispose() {
    weightFieldController.dispose();
    fieldFocusNode.dispose();
    super.dispose();
  }

  _onOkPressed() {
    String weight = weightFieldController.text;

    if (weight.isEmpty) return;

    String formattedWeight = weight.replaceAll(',', '.');

    if (!_isMetricSystem) {
      formattedWeight = WeightConversionUtils.convertLbsToKg(double.parse(formattedWeight)).toString();
    }

    context
        .read<DashboardWeightBloc>()
        .add(DashboardWeightEvent.logWeight(widget.selectedDay, double.parse(formattedWeight)));

    context.router.pop();
  }

  bool get _isToday => widget.selectedDay.midnightTime == DateTime.now().midnightTime;

  bool get _notEnableBtn => weightFieldController.text.isEmpty || weightFieldController.text == '0';

  void _onWeightChangeHandler(_) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: true,
        title: _isToday ? LocalizedTexts.todaysWeight.translation : LocalizedTexts.yourWeight.translation,
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 70.0),
                    Text(
                      LocalizedTexts.yourWeight.translation,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (!_isToday)
                      Text(
                        '${LocalizedTexts.on.tr()} ${widget.selectedDay.dayWithMonth} ${LocalizedTexts.was.tr()}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                  ],
                ),
                BlocBuilder<DashboardWeightBloc, DashboardWeightState>(builder: (BuildContext context, state) {
                  return UnitField(
                    onChanged: _onWeightChangeHandler,
                    unit: state.userWeightUnits,
                    controller: weightFieldController,
                    focusNode: fieldFocusNode,
                    isDecimal: true,
                    maxLength: 5,
                    counterText: '',
                  );
                }),
                Column(
                  children: [
                    OrangeButton(
                      onPressedHandler: _notEnableBtn ? null : _onOkPressed,
                      child: Text(LocalizedTexts.ok.translation.toUpperCase()),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
