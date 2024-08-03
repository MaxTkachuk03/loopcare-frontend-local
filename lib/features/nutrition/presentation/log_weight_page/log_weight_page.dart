import 'package:auto_route/auto_route.dart';
import 'package:customer_io/customer_io.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_attributes.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/get_measurement_system.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_field.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/utils/weight_conversion_utils.dart';

@RoutePage()
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
    super.initState();
    weightFieldController = TextEditingController(text: _getInputInitialValue());
    fieldFocusNode.requestFocus();
    CustomerIO.track(
      name: CIOEvents.weightWidget,
    );
  }

  String _getInputInitialValue() {
    final state = context.read<DashboardWeightBloc>().state;

    double? selectedDayWeightValue =
        state.data.getSelectedDayWeight(widget.selectedDay.isoStringWithoutTime);

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
      formattedWeight =
          WeightConversionUtils.convertLbsToKg(double.parse(formattedWeight)).toString();
    }

    context
        .read<DashboardWeightBloc>()
        .add(DashboardWeightEvent.logWeight(widget.selectedDay, double.parse(formattedWeight)));

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.weightLogged,
      parameters: {
        AnalyticsParameters.value: formattedWeight,
        AnalyticsParameters.measurementSystem: _isMetricSystem ? 'metric' : 'imperial',
      },
    );

    CustomerIO.track(
      name: CIOEvents.weightLogged,
      attributes: {
        CIOAttributes.weightLogged: formattedWeight,
        CIOAttributes.measurementSystem: _isMetricSystem
            ? MeasurementSystemType.metric.name
            : MeasurementSystemType.imperial.name,
      },
    );

    context.router.maybePop();
  }

  bool get _isToday => widget.selectedDay.midnightTime == DateTime.now().midnightTime;

  bool get _notEnableBtn => weightFieldController.text.isEmpty || weightFieldController.text == '0';

  void _onWeightChangeHandler(_) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final title = _isToday ? LocalizedTexts.todaysWeight.tr() : LocalizedTexts.yourWeight.tr();
    final yourWeight = _isToday
        ? LocalizedTexts.yourWeight.tr()
        : '${LocalizedTexts.yourWeight.tr()} ${LocalizedTexts.on.tr()}';

    return CustomScaffold.coralLightest(
      appBar: CustomAppBar.coral(
        leading: CustomFilledIconButton.leadingCoralLighter(),
        title: title,
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 70.0),
                    CustomText.bitter500(
                      yourWeight,
                      style: context.textTheme.displayMedium,
                    ),
                    if (!_isToday) ...[
                      const SizedBox(height: 12.0),
                      CustomText.bitter500(
                        widget.selectedDay.americanShortDateWithYear,
                        style: context.textTheme.displayMedium,
                      ),
                    ],
                  ],
                ),
                BlocBuilder<DashboardWeightBloc, DashboardWeightState>(
                  builder: (context, state) {
                    return UnitField(
                      onChanged: _onWeightChangeHandler,
                      unit: state.userWeightUnits,
                      controller: weightFieldController,
                      focusNode: fieldFocusNode,
                      isDecimal: true,
                      maxLength: 5,
                      counterText: '',
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: CustomElevatedButton.blueFullWidth(
                    onPressed: _notEnableBtn ? null : _onOkPressed,
                    label: LocalizedTexts.logWeight.tr(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
