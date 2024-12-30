import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/custom_app_icon/custom_app_icon.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/application/pool_bloc/pool_module_bloc.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/presentation/widgets/reflections_list.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class ReflectionsDashboardWidget extends StatefulWidget {
  final DateTime date;
  final bool locked;

  const ReflectionsDashboardWidget(
      {super.key, required this.date, required this.locked});

  @override
  State<ReflectionsDashboardWidget> createState() =>
      _ReflectionsDashboardWidgetState();
}

class _ReflectionsDashboardWidgetState
    extends State<ReflectionsDashboardWidget> {
  bool onClick = false;

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  void _onErrorHandler(BuildContext context) => context
      .read<ReflectionsBloc>()
      .add(const ReflectionsEvent.getReflections());

  void getPoolData(e) =>
      context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 16.0, right: 8.0, left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardCardTitle(
              onTap: () => widget.locked
                  ? context.router
                      .push(const MyReflectionsRoute())
                      .then(getPoolData)
                  : toggleOnClick(),
              highlightColor:
                  widget.locked ? AppColors.petrolLightest : AppColors.white,
              leadingIcon: widget.locked
                  ? const CustomAppIcon.reflection()
                  : const CustomAppIcon.reflectionGrey(),
              title: widget.locked
                  ? CustomText.bitter600(
                      LocalizedTexts.reflection.tr(),
                      style: context.textTheme.headlineSmall,
                    )
                  : CustomText.bitter400(
                      LocalizedTexts.reflection.tr(),
                      style: const TextStyle(
                          color: AppColors.greyLight, fontSize: 20),
                    ),
              actionIcon: widget.locked
                  ? AppIcons.arrow
                  : onClick
                      ? const AssetImage(AppIcons.upArrow)
                      : AppIcons.downArrow,
              circleButton: widget.locked ? true : false,
            ),
            widget.locked
                ? const Divider(
                    color: AppColors.blueLighter, indent: 8.0, endIndent: 8.0)
                : const SizedBox(),
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
                      children: [
                        Expanded(
                          child: CustomText.w400(
                            maxLines: 10,
                            LocalizedTexts.reflectionsDescription.tr(),
                            overflow: TextOverflow.visible,
                            style: const TextStyle(
                                color: AppColors.greyLight, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            widget.locked
                ? BlocBuilder<ReflectionsBloc, ReflectionsState>(
                    builder: (context, state) {
                      final hasReflections =
                          state.data.hasReflectionsForCurrentWeek(widget.date);

                      final selectedWeekReflections = state.data
                          .getSelectedWeekUndoneReflections(widget.date);

                      final doneTodayReflections =
                          state.data.getSelectedDayDoneReflections(widget.date);

                      final showDivider = doneTodayReflections.isNotEmpty &&
                          selectedWeekReflections.isNotEmpty;

                      return state.maybeMap(
                        loading: (_) =>
                            const SizedBox(height: 100, child: Loader()),
                        error: (errorState) {
                          final error = errorState.data.error;

                          return ErrorScreen(
                            error: error!,
                            onButtonPressed: () => _onErrorHandler(context),
                          );
                        },
                        orElse: () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: hasReflections
                              ? Column(
                                  children: [
                                    if (selectedWeekReflections.isNotEmpty)
                                      ReflectionsList(
                                        list: selectedWeekReflections,
                                        title: LocalizedTexts.thisWeek
                                            .tr()
                                            .capitalize(),
                                        fromDashboard: true,
                                      ),
                                    if (showDivider)
                                      const Divider(
                                          color: AppColors.blueLighter),
                                    if (doneTodayReflections.isNotEmpty)
                                      ReflectionsList(
                                        list: doneTodayReflections,
                                        title: LocalizedTexts.doneToday
                                            .tr()
                                            .capitalize(),
                                        fromDashboard: true,
                                      ),
                                  ],
                                )
                              : CustomText.w400(
                                  LocalizedTexts.allAssignmentsCompleted.tr(),
                                  style: context.textTheme.bodyMedium,
                                ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
