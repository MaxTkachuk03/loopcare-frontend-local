import 'package:auto_route/auto_route.dart';
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
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/weight/line_chart/line_chart.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/weight/widgets/measuring_params.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/utils/weight_conversion_utils.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class WeightBlock extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final bool unlocked;

  const WeightBlock(
      {super.key, required this.startDate, required this.endDate, required this.unlocked});

  @override
  State<WeightBlock> createState() => _WeightBlockState();
}

class _WeightBlockState extends State<WeightBlock> {
  bool onClick = false;
  final twoWeeksPeriod = 14.0;

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  void onPressHandler(BuildContext context) =>
      context.router.push(LogWeightRoute(selectedDay: widget.endDate)).then(getPoolData);

  void getPoolData(e) => context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocConsumer<DashboardWeightBloc, DashboardWeightState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (_) => context.read<DashboardWeightBloc>().add(DashboardWeightEvent.fetchWeights(
                widget.startDate.toString(), widget.endDate.toUtc().toIso8601String())),
          );
        },
        builder: (context, state) {
          return state.maybeMap(
            updated: (s) {
              final weightValue = s.data.getSelectedDayWeight(widget.endDate.isoStringWithoutTime);
              final weightDifferenceValue = s.data.weightDifference;
              final bool isEditable = s.isEditable(widget.endDate);
              final hasLog = weightValue != null;

              final inputWeightValue = s.isMetricSystem
                  ? weightValue
                  : WeightConversionUtils.convertKgToLbs(
                      weightValue ?? 0.0,
                    );

              final convertedWeightDifference = s.isMetricSystem
                  ? weightDifferenceValue
                  : WeightConversionUtils.convertKgToLbs(weightDifferenceValue);

              final text = hasLog
                  ? "${LocalizedTexts.onboardingWeight.tr()} : $inputWeightValue ${s.userWeightUnits}"
                  : isEditable
                      ? LocalizedTexts.logYourWeight.tr()
                      : LocalizedTexts.noWeightLogged.tr();

              final showSubText = !hasLog && isEditable;

              final templateSpots = [
                {'x': 0.0, 'y': 100.0},
                {'x': 1.0, 'y': 90.0},
                {'x': 3.0, 'y': 85.0},
                {'x': 4.0, 'y': 75.0},
                {'x': 6.0, 'y': 70.0},
                {'x': 7.0, 'y': 63.0},
                {'x': 8.0, 'y': 60.0},
                {'x': 9.0, 'y': 68.0},
                {'x': 10.0, 'y': 64.0},
              ];

              return Column(
                children: [
                  DashboardCardTitle(
                    onTap: () {
                      if (widget.unlocked) {
                        onPressHandler(context);
                      } else {
                        toggleOnClick();
                      }
                    },
                    highlightColor: widget.unlocked ? AppColors.coralLightest : AppColors.white,
                    leadingIcon: widget.unlocked
                        ? AppIcons.customDashboardWeight
                        : AppIcons.customDashboardWeightGrey,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.unlocked
                            ? CustomText.bitter600(
                                text,
                                style: context.textTheme.headlineSmall!.copyWith(
                                  color: isEditable ? AppColors.blueDarker : AppColors.greyLabel,
                                ),
                              )
                            : CustomText.bitter400(
                                LocalizedTexts.logWeight.tr(),
                                style: context.textTheme.headlineSmall!
                                    .copyWith(color: AppColors.greyLight, fontSize: 20),
                              ),
                        if (widget.unlocked)
                          if (showSubText)
                            CustomText.w400(
                              LocalizedTexts.preferableInTheMorning.tr(),
                              style: context.textTheme.bodySmall!.copyWith(
                                color: isEditable ? AppColors.blueDarker : AppColors.greyLabel,
                              ),
                            ),
                      ],
                    ),
                    circleButton: widget.unlocked ? true : false,
                    actionIcon: widget.unlocked
                        ? hasLog
                            ? AppIcons.edit
                            : AppIcons.plus
                        : onClick
                            ? const AssetImage(AppIcons.upArrow)
                            : AppIcons.downArrow,
                    editable: isEditable,
                  ),
                  widget.unlocked
                      ? const Divider(
                          color: AppColors.blueLighter,
                          indent: 8.0,
                          endIndent: 8.0,
                        )
                      : const SizedBox(),
                  widget.unlocked
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
                                  style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                  onClick && !widget.unlocked
                      ? Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomText.w400(
                                    maxLines: 10,
                                    LocalizedTexts.weightLogLockedDescription.tr(),
                                    style:
                                        const TextStyle(color: AppColors.greyLight, fontSize: 16),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  widget.unlocked
                      ? Column(
                          children: [
                            MeasuringParams(
                                textColor: state.data.weights.isNotEmpty
                                    ? AppColors.yellowRegular
                                    : AppColors.greyLight,
                                weightDifference: convertedWeightDifference.toDouble(),
                                userWeightUnits: s.userWeightUnits),
                            if (state.data.showChart)
                              LineChartWidget(
                                spots: state.data.getSpotsForChart(),
                                yMax: state.data.loggedWeightYMax,
                                xMax: twoWeeksPeriod,
                                lastDatePlacement: state.data.weightLogTimeLineMax!,
                                firstDate: state.data.firstLoggedWeightDate,
                                lastDate: state.data.lastLoggedWeightDate,
                                mainLineColor: AppColors.yellowOffRegular,
                                secondaryLineColor: AppColors.greyLight,
                              ),
                            if (!state.data.showChart)
                              // template
                              LineChartWidget(
                                spots: templateSpots,
                                yMax: 100.0,
                                xMax: twoWeeksPeriod,
                                lastDatePlacement: 10.0,
                                firstDate: widget.startDate,
                                lastDate: widget.endDate,
                                mainLineColor: AppColors.greyLight,
                                secondaryLineColor: AppColors.greyLight,
                              ),
                          ],
                        )
                      : Container(),
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
