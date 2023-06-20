import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/physical_activities/widgets/WeeklyActivitiesList.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';

class PhysicalActivities extends StatelessWidget {
  final DateTime selectedDay;

  const PhysicalActivities({Key? key, required this.selectedDay}) : super(key: key);

  void onPressHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.selectExercise);
  }

  get _isActive => selectedDay.midnightTime == DateTime.now().midnightTime;

  void _programLogged(BuildContext context, PhysicalProgramsState state) {
    context.read<PhysicalProgramsBloc>().add(const PhysicalProgramsEvent.getWeeklyPhysicalActivities());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhysicalProgramsBloc, PhysicalProgramsState>(
      listenWhen: (prev, cur) => cur is CustomProgramLogged,
      listener: _programLogged,
      child: Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: _isActive ? () => onPressHandler(context) : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 55.0, child: Image(image: AppIcons.physicalExercise)),
                      const SizedBox(width: 24.0),
                      Text(
                        LocalizedTexts.physicalActivities,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontFamily: ThemeConstants.bitterFontFamily,
                              color: _isActive ? AppColors.darkGreen : AppColors.greyLabel,
                            ),
                      ).tr(),
                    ],
                  ),
                  const ImageIcon(
                    AppIcons.arrow,
                    color: AppColors.greyLabel,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            const Divider(color: AppColors.yellowLight),
            const SizedBox(height: 6.0),
            BlocBuilder<PhysicalProgramsBloc, PhysicalProgramsState>(builder: (BuildContext context, state) {
              return state.maybeMap(
                  loading: (_) => const Loader(),
                  orElse: () => const SizedBox.shrink(),
                  calendarProgramsLoaded: (s) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '3 ${LocalizedTexts.activitiesForThisWeek.toUpperCase()}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.greyLabel,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        WeeklyActivitiesList(data: s.data.activities),
                      ],
                    );
                  });
            }),
          ],
        ),
      ),
    );
  }
}
