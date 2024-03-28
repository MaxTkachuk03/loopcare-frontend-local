import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/dashboard_assignments/this_week_assignments_open.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/my_assignments/past_assignments.dart';
import 'package:loopcare_frontend/injection.dart';

class MyAssignmentsPage extends StatefulWidget {
  const MyAssignmentsPage({super.key});

  @override
  State<MyAssignmentsPage> createState() => _MyAssignmentsPageState();
}

class _MyAssignmentsPageState extends State<MyAssignmentsPage> {
  DateTime emailApproveDate = getIt<SharedStorageService>().account?.emailApproveDate ?? DateTime.now();

  @override
  void initState() {
    super.initState();

    context
        .read<AssignmentsBloc>()
        .add(AssignmentsEvent.getAllLessonQuestions(emailApproveDate, DateTime.now()));
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
    return CustomScaffold.coral(
      appBar: CustomAppBar.coral(
        title: LocalizedTexts.assignments.translation,
        leading: CustomFilledIconButton.leadingCoralLighter(),
      ),
      body: BlocBuilder<AssignmentsBloc, AssignmentsState>(
        builder: (context, state) {
          final thisWeekAssignments = state.data.currentWeekAssignments(DateTime.now());
          final pastAssignments = state.data.pastAssignments(emailApproveDate);

          return state.maybeMap(
            loading: (_) => const Loader(),
            orElse: () {
              return CustomSafeArea(
                child: ScrollableContainer(
                  child: (thisWeekAssignments.isNotEmpty || pastAssignments.isNotEmpty)
                      ? MainContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 28.0),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 22.0),
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (thisWeekAssignments.isNotEmpty)
                                      ThisWeekAssignmentsOpen(
                                        onDashboard: false,
                                        questions: thisWeekAssignments,
                                        onBtnPressed: (int lessonId) =>
                                            _startLessonQuestion(context, lessonId),
                                      ),
                                    if (thisWeekAssignments.isNotEmpty && pastAssignments.isNotEmpty)
                                      const Column(
                                        children: [Divider(color: AppColors.ff404040), SizedBox(height: 18)],
                                      ),
                                    if (pastAssignments.isNotEmpty)
                                      PastAssignments(
                                        questions: pastAssignments,
                                        onBtnPressed: (int lessonId) =>
                                            _startLessonQuestion(context, lessonId),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
