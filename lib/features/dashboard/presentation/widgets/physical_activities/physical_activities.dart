import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/application/physical_activities_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/application/programs_in_progress_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/widgets/empty_activities_list.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/widgets/filled_activities_list.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/application/pool_bloc/pool_module_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class PhysicalActivities extends StatefulWidget {
  final DateTime selectedDay;
  final bool locked;
  const PhysicalActivities({super.key, required this.selectedDay, required this.locked});

  @override
  State<PhysicalActivities> createState() => _PhysicalActivitiesState();
}

class _PhysicalActivitiesState extends State<PhysicalActivities> {
  bool onClick = false;

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  void didUpdateWidget(covariant PhysicalActivities oldWidget) {
    if (oldWidget.selectedDay.isoStringWithoutTime == widget.selectedDay.isoStringWithoutTime) {
      return;
    }
    _updateData();
    super.didUpdateWidget(oldWidget);
  }

  void _updateData() {
    context
        .read<PhysicalActivitiesBloc>()
        .add(PhysicalActivitiesEvent.getWeeklyPhysicalActivities(widget.selectedDay));

    context
        .read<ProgramsInProgressBloc>()
        .add(const ProgramsInProgressEvent.removeExpiredPrograms());
  }

  void onPressHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.selectExercise).then(getPoolData);
  }

  get _isActive => widget.selectedDay.midnightTime == DateTime.now().midnightTime;

  void _programLogged(BuildContext context, PhysicalProgramsState state) {
    context
        .read<PhysicalActivitiesBloc>()
        .add(PhysicalActivitiesEvent.getWeeklyPhysicalActivities(widget.selectedDay));
  }

  void getPoolData(e) => context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhysicalProgramsBloc, PhysicalProgramsState>(
      listenWhen: (prev, cur) => cur is ProgramUpdated,
      listener: _programLogged,
      child: Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 8.0, left: 8.0),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: BlocBuilder<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
          builder: (context, state) {
            final isAvailable = state.data.needActivitiesType;

            return Column(
              children: [
                DashboardCardTitle(
                  onTap: _isActive && isAvailable
                      ? () => widget.locked ? onPressHandler(context) : toggleOnClick()
                      : null,
                  highlightColor: widget.locked ? AppColors.yellowLightest : AppColors.white,
                  leadingIcon: widget.locked
                      ? AppIcons.customPhysicalExercise
                      : AppIcons.customPhysicalExerciseGrey,
                  title: widget.locked
                      ? CustomText.bitter600(
                          LocalizedTexts.physicalActivities.tr(),
                          style: context.textTheme.headlineSmall!.copyWith(
                            color: _isActive && isAvailable
                                ? AppColors.blueDarker
                                : AppColors.greyLabel,
                          ),
                        )
                      : CustomText.bitter400(
                          LocalizedTexts.physicalActivities.tr(),
                          style: context.textTheme.headlineSmall!
                              .copyWith(color: AppColors.greyLight, fontSize: 20),
                        ),
                  actionIcon: widget.locked
                      ? AppIcons.arrow
                      : onClick
                          ? const AssetImage(AppIcons.upArrow)
                          : AppIcons.downArrow,
                  editable: isAvailable,
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
                            SizedBox(
                              width: 250,
                              child: CustomText.w400(
                                "${LocalizedTexts.featureUnlocksAtPool.tr()} #${LocalizedTexts.exerciseLibrary.tr()}",
                                style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
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
                            SizedBox(
                              width: 350,
                              child: CustomText.w400(
                                maxLines: 10,
                                LocalizedTexts.exerciseLibraryDescription.tr(),
                                style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                widget.locked
                    ? const Divider(
                        color: AppColors.blueLighter,
                        indent: 8.0,
                        endIndent: 8.0,
                      )
                    : const SizedBox(),
                widget.locked ? const SizedBox(height: 4.0) : const SizedBox(),
                widget.locked
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BlocBuilder<ProgramsInProgressBloc, ProgramsInProgressState>(
                          builder: (context, state) {
                            final activePrograms = state.programsList;

                            return BlocBuilder<PhysicalActivitiesBloc, PhysicalActivitiesState>(
                              builder: (context, state) {
                                return state.maybeMap(
                                  error: (errorState) => ErrorScreen(
                                    error: errorState.data.error!,
                                    onButtonPressed: () =>
                                        context.read<PhysicalActivitiesBloc>().add(
                                              PhysicalActivitiesEvent.getWeeklyPhysicalActivities(
                                                widget.selectedDay,
                                              ),
                                            ),
                                  ),
                                  loading: (_) => const SizedBox(height: 100, child: Loader()),
                                  orElse: () => const SizedBox.shrink(),
                                  activitiesLoaded: (s) {
                                    final int timesPerWeek =
                                        getIt<SharedStorageService>().account!.trainingFrequency;

                                    return isAvailable
                                        ? FilledActivitiesList(
                                            programsList: [
                                              ...activePrograms,
                                              ...s.data.activities(timesPerWeek),
                                            ],
                                          )
                                        : const EmptyActivitiesList();
                                  },
                                );
                              },
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
