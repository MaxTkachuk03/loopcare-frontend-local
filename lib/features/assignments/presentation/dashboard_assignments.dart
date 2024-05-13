import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/dashboard_assignments/this_week_assignments.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';

class DashboardAssignments extends StatefulWidget {
  final DateTime date;

  const DashboardAssignments({super.key, required this.date});

  @override
  State<DashboardAssignments> createState() => _DashboardAssignmentsState();
}

class _DashboardAssignmentsState extends State<DashboardAssignments> {
  @override
  void initState() {
    super.initState();

    context.read<AssignmentsBloc>().add(
          AssignmentsEvent.getAllLessonQuestions(
            widget.date.firstDayOfCurrentWeek.subtract(const Duration(days: 7)),
            widget.date.lastDayOfCurrentWeek,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 8.0, left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardCardTitle(
              onTap: () => context.router.push(const MyAssignmentsRoute()),
              highlightColor: AppColors.petrolLightest,
              leadingIcon: AppIcons.customDashboardAssignments,
              title: CustomText.bitter600(
                LocalizedTexts.assignments.tr(),
                style: context.textTheme.headlineSmall,
              ),
              actionIcon: AppIcons.arrow,
              circleButton: false,
            ),
            const Divider(
              color: AppColors.blueLighter,
              indent: 8.0,
              endIndent: 8.0,
            ),
            BlocBuilder<AssignmentsBloc, AssignmentsState>(
              builder: (context, state) {
                final hasQuestions = state.data.hasQuestionsForCurrentWeek(widget.date);

                return state.maybeMap(
                  loading: (_) => const SizedBox(height: 100, child: Loader()),
                  error: (errorState) {
                    final error = errorState.data.error;

                    return ErrorScreen(
                      error: error!,
                      onButtonPressed: () => context.read<AssignmentsBloc>().add(
                            AssignmentsEvent.getAllLessonQuestions(
                              widget.date.beginDay,
                              widget.date.endDay,
                            ),
                          ),
                    );
                  },
                  orElse: () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: hasQuestions
                          ? ThisWeekAssignments(
                              weekQuestions: state.data.currentWeekAssignments(widget.date),
                              todayQuestions: state.data.todayDoneAssignments(widget.date),
                            )
                          : CustomText.w400(
                              LocalizedTexts.allAssignmentsCompleted.tr(),
                              style: context.textTheme.bodyMedium,
                            ),
                    ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
