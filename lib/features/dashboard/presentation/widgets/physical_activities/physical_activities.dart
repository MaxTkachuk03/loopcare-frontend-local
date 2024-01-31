import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/dashboard/application/physical_activities_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/application/programs_in_progress_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/widgets/empty_activities_list.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/widgets/filled_activities_list.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';

class PhysicalActivities extends StatefulWidget {
  final DateTime selectedDay;

  const PhysicalActivities({super.key, required this.selectedDay});
  @override
  State<PhysicalActivities> createState() => _PhysicalActivitiesState();
}

class _PhysicalActivitiesState extends State<PhysicalActivities> {
  @override
  void initState() {
    _updateData();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant PhysicalActivities oldWidget) {
    if (oldWidget.selectedDay.isoStringWithoutTime == widget.selectedDay.isoStringWithoutTime) return;

    _updateData();

    super.didUpdateWidget(oldWidget);
  }

  void _updateData() {
    context
        .read<PhysicalActivitiesBloc>()
        .add(PhysicalActivitiesEvent.getWeeklyPhysicalActivities(widget.selectedDay));

    context.read<ProgramsInProgressBloc>().add(const ProgramsInProgressEvent.removeExpiredPrograms());
  }

  void onPressHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.selectExercise);
  }

  get _isActive => widget.selectedDay.midnightTime == DateTime.now().midnightTime;

  void _programLogged(BuildContext context, PhysicalProgramsState state) {
    context
        .read<PhysicalActivitiesBloc>()
        .add(PhysicalActivitiesEvent.getWeeklyPhysicalActivities(widget.selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhysicalProgramsBloc, PhysicalProgramsState>(
      listenWhen: (prev, cur) => cur is ProgramUpdated,
      listener: _programLogged,
      child: Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: BlocBuilder<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
          builder: (BuildContext context, physicalActivitiesPreferencesState) {
            final isAvailable = physicalActivitiesPreferencesState.data.needActivitiesType;

            return Column(
              children: [
                InkWell(
                  onTap: _isActive && isAvailable ? () => onPressHandler(context) : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppIcons.customPhysicalExercise,
                          const SizedBox(width: 24.0),
                          CustomText.bitter600(
                            LocalizedTexts.physicalActivities.tr(),
                            style: context.textTheme.headlineSmall!.copyWith(
                              color: _isActive && isAvailable ? AppColors.blueDarker : AppColors.greyLabel,
                            ),
                          ),
                        ],
                      ),
                      if (isAvailable) const ImageIcon(AppIcons.arrow, color: AppColors.blueDarker),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                const Divider(color: AppColors.blueOffRegular),
                const SizedBox(height: 6.0),
                BlocBuilder<ProgramsInProgressBloc, ProgramsInProgressState>(
                  builder: (BuildContext context, state) {
                    final activePrograms = state.programsList;

                    return BlocBuilder<PhysicalActivitiesBloc, PhysicalActivitiesState>(
                      builder: (BuildContext context, state) {
                        return state.maybeMap(
                          error: (errorState) {
                            final error = errorState.data.error;

                            return ErrorScreen(
                              smallVersion: true,
                              error: error!,
                              onButtonPressed: () => context.read<PhysicalActivitiesBloc>().add(
                                  PhysicalActivitiesEvent.getWeeklyPhysicalActivities(widget.selectedDay)),
                            );
                          },
                          loading: (_) => const Loader(),
                          orElse: () => const SizedBox.shrink(),
                          activitiesLoaded: (s) {
                            final int timesPerWeek =
                                context.read<AuthenticationCubit>().state.trainingFrequency!;

                            return isAvailable
                                ? FilledActivitiesList(
                                    programsList: [...activePrograms, ...s.data.activities(timesPerWeek)])
                                : const EmptyActivitiesList();
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
