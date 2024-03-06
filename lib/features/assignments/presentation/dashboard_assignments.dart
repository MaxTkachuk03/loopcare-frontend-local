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

class DashboardAssignments extends StatelessWidget {
  final DateTime date;

  const DashboardAssignments({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => context.router.push(const MyAssignmentsRoute()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AppIcons.customDashboardAssignments,
                      const SizedBox(width: 24.0),
                      CustomText.bitter600(
                        LocalizedTexts.assignments.tr(),
                        style: context.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const ImageIcon(
                    AppIcons.arrow,
                    color: AppColors.blueDarker,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            const Divider(color: AppColors.blueOffRegular),
            BlocBuilder<AssignmentsBloc, AssignmentsState>(
              builder: (context, state) {
                return state.maybeMap(
                  loading: (_) => const SizedBox(height: 100, child: Loader()),
                  error: (errorState) {
                    final error = errorState.data.error;

                    return ErrorScreen(
                      error: error!,
                      onButtonPressed: () => context.read<AssignmentsBloc>().add(
                            AssignmentsEvent.getAllLessonQuestions(
                              date.beginDay,
                              date.endDay,
                            ),
                          ),
                    );
                  },
                  orElse: () {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.data.questionsForCurrentWeek(date).isEmpty)
                          CustomText.w400(
                            LocalizedTexts.allAssignmentsCompleted.tr(),
                            style: context.textTheme.bodyMedium,
                          ),
                        if (state.data.questionsForCurrentWeek(date).isNotEmpty)
                          ThisWeekAssignments(
                            weekQuestions: state.data.uniqueLessonsQuestions(
                              state.data.openedQuestionsForCurrentWeek(date),
                            ),
                            todayQuestions: state.data.uniqueLessonsQuestions(
                              state.data.doneTodayQuestions(date),
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
