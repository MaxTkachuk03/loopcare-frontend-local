import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/activity_tracker/application/activity_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/activity_tracker_dashboard/widgets/custom_progress_painter.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:health_kit_reporter/health_kit_reporter.dart';
import 'package:health_kit_reporter/model/predicate.dart';
import 'package:health_kit_reporter/model/type/quantity_type.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/localization/service/Localized_texts.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';

class ActivityTrackerDashboard extends StatefulWidget {
  final DateTime date;
  final bool locked;
  const ActivityTrackerDashboard({super.key, required this.date, required this.locked});

  @override
  State<ActivityTrackerDashboard> createState() => _ActivityTrackerDashboardState();
}

class _ActivityTrackerDashboardState extends State<ActivityTrackerDashboard> {
  bool onClick = false;
  bool isStepsAvailable = false;
  double stepCount = 0;

  void initWidget() {
    if (widget.locked) {
      _getStepCount();
    }
  }

  @override
  void initState() {
    super.initState();
    widget.locked ? initWidget() : null;
  }

  @override
  void didUpdateWidget(covariant ActivityTrackerDashboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.date != oldWidget.date) {
      _stepsLogged();
    }
  }

  Future<void> callBloc(List<Map<String, dynamic>> body) async {
    final bloc = context.read<ActivityBloc>();
    bloc.add(ActivityEvent.saveActivity(body));
  }

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  Future<void> _getStepCount() async {
    if (Platform.isIOS) {
      try {
        final now = DateTime.now();
        final startOfDay = DateTime(now.year, now.month, now.day);
        final predicate = Predicate(startOfDay, now);
        final steps = await HealthKitReporter.quantityQuery(
          QuantityType.stepCount,
          'count',
          predicate,
        );

        double totalSteps = steps.fold(0, (sum, step) => sum + step.harmonized.value);

        setState(() {
          stepCount = totalSteps;
          isStepsAvailable = true;
        });

        if (totalSteps != 0) {
          await callBloc([
            {"loggingDate": startOfDay.toIso8601String().split('T')[0], "steps": totalSteps}
          ]);
          isStepsAvailable = true;
        }
      } catch (e) {
        e;
      }
    }
    if (Platform.isAndroid) {
      try {
        final today = DateTime.now();
        final startTime = DateTime(today.year, today.month, today.day);
        final endTime = DateTime(today.year, today.month, today.day, 23, 59, 59);
        final stepRecords = await HealthConnectFactory.getRecord(
          type: HealthConnectDataType.Steps,
          startTime: startTime,
          endTime: endTime,
        );

        int totalSteps = 0;
        if (stepRecords.containsKey('records')) {
          List<dynamic> records = stepRecords['records'];

          for (var record in records) {
            final count = (record['count'] ?? 0) as int;
            totalSteps += count;
          }
        }

        setState(() {
          stepCount = totalSteps.toDouble();
          isStepsAvailable = true;
        });

        if (totalSteps != 0) {
          await callBloc([
            {
              "loggingDate":
                  "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}",
              "steps": totalSteps
            }
          ]);
        }
      } catch (e) {
        e;
      }
    }
  }

  void _stepsLogged() {
    final startDate = widget.date.dateStringOnly;
    final endDate = widget.date.dateStringOnly;

    context
        .read<ActivityBloc>()
        .add(ActivityEvent.getActivity(startDate: startDate, endDate: endDate));

    final state = context.read<ActivityBloc>().state;
    final dataList = state.data.data;

    if (dataList != null && dataList.isNotEmpty) {
      final steps = dataList.first.steps ?? 0;
      final dateNow = DateTime.now().dateStringOnly;
      final currentDate = widget.date.dateStringOnly;

      if (currentDate == dateNow) {
        _getStepCount();
        if (Platform.isAndroid) {
          setState(() {
            _getStepCount();
            !widget.locked;
          });
        }
      } else {
        setState(() {
          stepCount = steps.toDouble();
        });
      }
    } else {
      setState(() {
        stepCount = 0;
      });
    }
  }

  Future<bool> _requestPermission() async {
    if (Platform.isIOS) {
      final readTypes = <String>[
        QuantityType.stepCount.identifier,
      ];
      final writeTypes = <String>[];
      final isAuthorized = await HealthKitReporter.requestAuthorization(readTypes, writeTypes);
      if (isAuthorized) {
        _getStepCount();
        return true;
      }
      return false;
    }

    if (Platform.isAndroid) {
      final dataTypes = [HealthConnectDataType.Steps];
      final hasPermission = await HealthConnectFactory.hasPermissions(dataTypes);
      if (!hasPermission) {
        final granted = await HealthConnectFactory.requestPermissions(dataTypes);
        return granted;
      } else {
        _getStepCount();
        return true;
      }
    }

    return false;
  }

  final bool isEditable = true;
  @override
  Widget build(BuildContext context) {
    int stepCount2 = stepCount.toInt();
    final Color textColor = isEditable ? AppColors.blueDarker : AppColors.greyLabel;
    return Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 8.0, left: 8.0),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            DashboardCardTitle(
              onTap: () {
                if (widget.locked) {
                  _requestPermission();
                } else {
                  toggleOnClick();
                }
              },
              highlightColor: widget.locked ? AppColors.orangeLightest : AppColors.white,
              leadingIcon: widget.locked
                  ? AppIcons.customPhysicalExercise
                  : AppIcons.customPhysicalExerciseGrey,
              title: widget.locked
                  ? CustomText.bitter600(
                      LocalizedTexts.activityTracker.tr(),
                      style: context.textTheme.headlineSmall?.copyWith(color: textColor),
                    )
                  : CustomText.bitter400(
                      LocalizedTexts.activityTracker.tr(),
                      style: context.textTheme.headlineSmall
                          ?.copyWith(color: AppColors.greyLight, fontSize: 20),
                    ),
              actionIcon: widget.locked
                  ? AppIcons.plus
                  : onClick
                      ? const AssetImage(AppIcons.upArrow)
                      : AppIcons.downArrow,
              editable: isEditable,
              circleButton: widget.locked ? true : false,
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
                            "${LocalizedTexts.featureUnlocksAtPool.tr()} ${LocalizedTexts.reflectionsUnlock.tr()}",
                            style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
            onClick && !widget.locked
                ? Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText.w400(
                            maxLines: 10,
                            LocalizedTexts.activityTrackerLocked.tr(),
                            style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            widget.locked ? const SizedBox(height: 4.0) : const SizedBox(),
            widget.locked && isStepsAvailable
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Card(
                            elevation: 10,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: 5,
                                  child: AppIcons.stepper,
                                ),
                                CustomPaint(
                                  size: const Size(75, 75),
                                  painter: CustomProgressPainter(
                                    progress: 0,
                                    strokeWidth: 7,
                                    progressColor: AppColors.yellowMid,
                                    backgroundColor: AppColors.blueLightest,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText.w700(
                                      "$stepCount2",
                                      style: const TextStyle(
                                          fontSize: 16, color: AppColors.blueDarker),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ));
  }
}
