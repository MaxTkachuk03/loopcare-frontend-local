import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/application/pool_bloc/pool_module_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/utils/weight_conversion_utils.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class WeightBlock extends StatefulWidget {
  final DateTime date;
  final bool locked;

  const WeightBlock({super.key, required this.date, required this.locked});

  @override
  State<WeightBlock> createState() => _WeightBlockState();
}

class _WeightBlockState extends State<WeightBlock> {
  bool onClick = false;

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  void onPressHandler(BuildContext context) => context.router
      .push(LogWeightRoute(selectedDay: widget.date))
      .then(getPoolData);

  void getPoolData(e) =>
      context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocConsumer<DashboardWeightBloc, DashboardWeightState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (_) => context.read<DashboardWeightBloc>().add(
                DashboardWeightEvent.fetchWeights(
                    widget.date.toUtc().toIso8601String())),
          );
        },
        builder: (context, state) {
          return state.maybeMap(
            updated: (s) {
              final weightValue =
                  s.data.getSelectedDayWeight(widget.date.isoStringWithoutTime);
              final bool isEditable = s.isEditable(widget.date);
              final hasLog = weightValue != null;

              final inputWeightValue = s.isMetricSystem
                  ? weightValue
                  : WeightConversionUtils.convertKgToLbs(
                      weightValue ?? 0.0,
                    );

              final text = hasLog
                  ? "${LocalizedTexts.onboardingWeight.tr()} : $inputWeightValue ${s.userWeightUnits}"
                  : isEditable
                      ? LocalizedTexts.logYourWeight.tr()
                      : LocalizedTexts.noWeightLogged.tr();

              final showSubText = !hasLog && isEditable;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardCardTitle(
                    onTap: () {
                      if (widget.locked) {
                        onPressHandler(context);
                      } else {
                        toggleOnClick();
                      }
                    },
                    highlightColor: widget.locked
                        ? AppColors.coralLightest
                        : AppColors.white,
                    leadingIcon: widget.locked
                        ? AppIcons.customDashboardWeight
                        : AppIcons.customDashboardWeightGrey,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.locked
                            ? CustomText.bitter600(
                                text,
                                style:
                                    context.textTheme.headlineSmall!.copyWith(
                                  color: isEditable
                                      ? AppColors.blueDarker
                                      : AppColors.greyLabel,
                                ),
                              )
                            : CustomText.bitter400(
                                LocalizedTexts.logWeight.tr(),
                                style: context.textTheme.headlineSmall!
                                    .copyWith(
                                        color: AppColors.greyLight,
                                        fontSize: 20),
                              ),
                        if (widget.locked)
                          if (showSubText)
                            CustomText.w400(
                              LocalizedTexts.preferableInTheMorning.tr(),
                              style: context.textTheme.bodySmall!.copyWith(
                                color: isEditable
                                    ? AppColors.blueDarker
                                    : AppColors.greyLabel,
                              ),
                            ),
                      ],
                    ),
                    circleButton: widget.locked ? true : false,
                    actionIcon: widget.locked
                        ? hasLog
                            ? AppIcons.edit
                            : AppIcons.plus
                        : onClick
                            ? const AssetImage(AppIcons.upArrow)
                            : AppIcons.downArrow,
                    editable: isEditable,
                  ),
                  widget.locked
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              AppIcons.lockGoals,
                              const SizedBox(
                                width: 36,
                              ),
                              Expanded(
                                child: CustomText.w400(
                                  "${LocalizedTexts.featureUnlocksAtPool.tr()} ${LocalizedTexts.weightLog.tr()}",
                                  style: const TextStyle(
                                      color: AppColors.greyLight, fontSize: 16),
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                  onClick && !widget.locked
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12.0, bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomText.w400(
                                    maxLines: 10,
                                    LocalizedTexts.weightLogLockedDescription
                                        .tr(),
                                    style: const TextStyle(
                                        color: AppColors.greyLight,
                                        fontSize: 16),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Divider(
                        color: AppColors.greyRegular,
                        height: 1.0,
                        indent: 8.0,
                        endIndent: 8.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _WeightIndicators(
                            text: LocalizedTexts.onboardingWeight.tr(),
                            number:
                                s.data.weights.values.first.weight.toString(),
                            userWeightUnits: s.userWeightUnits),
                        _WeightIndicators(
                            text: 'Bodyfat',
                            number: '-3,1',
                            userWeightUnits: '%'),
                        _WeightIndicators(
                            text: 'BMI', number: '-2,4', userWeightUnits: ''),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: _Chart(
                        inputWeightValue: s.data.weights.values.first.weight,
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: (_) => const Loader(),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _WeightIndicators extends StatelessWidget {
  const _WeightIndicators({
    super.key,
    required this.text,
    required this.number,
    required this.userWeightUnits,
  });

  final String text;
  final String number;
  final String userWeightUnits;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText.w700("$number$userWeightUnits",
            style: context.textTheme.bodyMedium
                ?.copyWith(color: AppColors.yellowMid)),
        CustomText.w400(text, style: context.textTheme.bodySmall),
      ],
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    super.key,
    required this.inputWeightValue,
  });

  static final List<Color> gradientColors = [
    AppColors.white,
    AppColors.yellowRegular,
    AppColors.white.withOpacity(0),
  ];

  final num inputWeightValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            touchSpotThreshold: 5,
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipPadding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              tooltipRoundedRadius: 20,
              tooltipBorder: const BorderSide(color: AppColors.white),
              getTooltipColor: (touchedSpot) => AppColors.blueRegular,

              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((touchedSpot) {
                  if (touchedSpot.x == 3) {
                    // Точка "today"
                    return LineTooltipItem(
                      'today',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return null;
                }).toList();
              },
            ),
          ),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              // drawBelowEverything: true,
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  );
                  Widget text;
                  switch (value.toInt()) {
                    case 2:
                      text = const Text('week', style: style);
                      break;
                    case 7:
                      text = const Text('44', style: style);
                      break;
                    case 12:
                      text = const Text('45', style: style);
                      break;
                    default:
                      text = const Text('');
                      break;
                  }

                  return SideTitleWidget(
                    // meta: meta,
                    space: 2,
                    axisSide: AxisSide.bottom,
                    child: text,
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: AppColors.greyRegular, width: 1.0),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              preventCurveOverShooting: true,
              isCurved: true,
              color: AppColors.yellowRegular,
              barWidth: 1.5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
                getDotPainter: (spot, _, __, ___) {
                  return FlDotCirclePainter(
                    radius: 6,
                    color: Colors.white,
                    strokeWidth: 3,
                    strokeColor: Colors.orange,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  tileMode: TileMode.mirror,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:
                      gradientColors.map((c) => c.withOpacity(0.8)).toList(),
                ),
              ),
              spots: [
                FlSpot(1, 68),
                FlSpot(3, 71),
                FlSpot(7, 75),
                FlSpot(10, inputWeightValue.toDouble()),
                FlSpot(12, 73),
                FlSpot(13, 70),
              ],
            ),
          ],
          minX: 1,
          maxX: 20,
          maxY: 100,
          minY: 0,
        ),
        duration: const Duration(milliseconds: 300), // Optional
        curve: Curves.linearToEaseOut, // Optional
      ),
    );
  }
}
