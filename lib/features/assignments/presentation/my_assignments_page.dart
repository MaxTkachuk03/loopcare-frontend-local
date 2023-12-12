import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/dashboard_assignments/this_week_assignments_open.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/my_assignments/past_assignments.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';

class MyAssignmentsPage extends StatefulWidget {
  const MyAssignmentsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyAssignmentsPage> createState() => _MyAssignmentsPageState();
}

class _MyAssignmentsPageState extends State<MyAssignmentsPage> {
  late DateTime emailApproveDate;

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthenticationCubit>().state;
    emailApproveDate = authState.emailApproveDate ?? DateTime.now();

    context.read<AssignmentsBloc>().add(
          AssignmentsEvent.getAllLessonQuestions(
            emailApproveDate,
            DateTime.now(),
          ),
        );
  }

  _startLessonQuestion(BuildContext context, int lessonId) {
    context.router.push(
      AssignmentsIntroRoute(
        lessonId: lessonId,
        fromDashboard: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: true,
        title: LocalizedTexts.assignments.translation,
      ),
      body: BlocBuilder<AssignmentsBloc, AssignmentsState>(
        builder: (context, state) {
          var thisWeekQuestions =
              state.data.uniqueLessonsQuestions(state.data.openedQuestionsForCurrentWeek(DateTime.now()));
          var pastQuestions = state.data.uniqueLessonsQuestions(state.data.pastQuestions(emailApproveDate));

          return state.maybeMap(
            loading: (_) => const Loader(),
            orElse: () {
              return SafeArea(
                child: MainContainer(
                  child: ScrollableContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24.0),
                        if (thisWeekQuestions.isNotEmpty)
                          ThisWeekAssignmentsOpen(
                            onDashboard: false,
                            questions: thisWeekQuestions,
                            onBtnPressed: (int lessonId) => _startLessonQuestion(context, lessonId),
                          ),
                        if (thisWeekQuestions.isNotEmpty && pastQuestions.isNotEmpty)
                          const Divider(color: AppColors.FF404040),
                        if (pastQuestions.isNotEmpty)
                          PastAssignments(
                            questions: pastQuestions,
                            onBtnPressed: (int lessonId) => _startLessonQuestion(context, lessonId),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
