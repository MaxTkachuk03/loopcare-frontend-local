import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/physical_activities_image_header.dart';

class AssignmentsIntroPage extends StatefulWidget {
  final int lessonId;

  const AssignmentsIntroPage({
    super.key,
    required this.lessonId,
  });

  @override
  State<AssignmentsIntroPage> createState() => _AssignmentsIntroPageState();
}

class _AssignmentsIntroPageState extends State<AssignmentsIntroPage> {
  @override
  void initState() {
    super.initState();

    context.read<AssignmentsBloc>().add(AssignmentsEvent.getLessonQuestions(widget.lessonId));
  }

  _seeLessonBtnPressed(BuildContext context) {
    context.read<EducationLessonBloc>().add(
          EducationLessonEvent.getLessonContent(
            lessonId: widget.lessonId,
            pageIndex: 0,
          ),
        );

    context.router.pushNamed('/lesson/${widget.lessonId}/page/0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Column(
          children: [
            Text(
              LocalizedTexts.assignment.translation,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              LocalizedTexts.introduction.translation,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const ProgressBar(
                    progress: 33,
                    backgroundColor: AppColors.white,
                  ),
                  const PhysicalActivitiesImageHeader(),
                  const SizedBox(height: 30.0),
                  MainContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                LocalizedTexts.assignment.translation.toUpperCase(),
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontSize: ThemeConstants.fontSize12,
                                      color: AppColors.orangeDark,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 32.0),
                            BlocBuilder<AssignmentsBloc, AssignmentsState>(
                              builder: (context, state) {
                                var questions = state.data.questions;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      questions.isNotEmpty ? questions.first.title : '',
                                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                            fontSize: ThemeConstants.fontSize24,
                                          ),
                                    ),
                                    const SizedBox(height: 32.0),
                                    Text(
                                      questions.isNotEmpty ? questions.first.instruction : '',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 24.0),
                            SizedBox(
                              width: 160,
                              height: 40,
                              child: OutlinedButton(
                                onPressed: () => _seeLessonBtnPressed(context),
                                child: Text(LocalizedTexts.seeLesson.translation),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SafeArea(
                top: false,
                child: MainContainer(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 53.0),
                    child: ElevatedButton(
                      onPressed: () => _onStart(context),
                      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                            backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                          ),
                      child: Text(LocalizedTexts.letsGo.tr()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onStart(BuildContext context) {
    context.router.push(AssignmentsQuestionsRoute(step: 0));
  }
}
