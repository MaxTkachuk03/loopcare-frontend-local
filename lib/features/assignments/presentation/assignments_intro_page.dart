import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

@RoutePage()
class AssignmentsIntroPage extends StatefulWidget {
  final RiverModuleStreamType streamType;
  final int lessonId;
  final bool fromDashboard;

  const AssignmentsIntroPage({
    super.key,
    required this.lessonId,
    required this.fromDashboard,
    this.streamType = RiverModuleStreamType.psychology,
  });

  @override
  State<AssignmentsIntroPage> createState() => _AssignmentsIntroPageState();
}

class _AssignmentsIntroPageState extends State<AssignmentsIntroPage> {
  String questionId = '';
  String questionTitle = '';

  @override
  void initState() {
    super.initState();

    context.read<AssignmentsBloc>().add(AssignmentsEvent.getLessonQuestions(widget.lessonId));
  }

  _seeLessonBtnPressed(BuildContext context) {
    context
        .read<EducationLessonBloc>()
        .add(EducationLessonEvent.getLessonContent(lessonId: widget.lessonId, pageIndex: 0));

    context.router.pushNamed('/lesson/${widget.lessonId}/page/0');
  }

  void _onStart() {
    context.router.push(AssignmentsQuestionsRoute(
        step: 0, fromDashboard: widget.fromDashboard, streamType: widget.streamType));
  }

  Future<bool> _onPreviousPage(BuildContext context) {
    AnalyticsEventService.instance.finalizeAssignment(
      FirebaseEvents.userLeftAssignment,
      questionId,
      questionTitle,
      widget.fromDashboard,
    );

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPreviousPage(context),
      child: CustomScaffold(
        color: widget.streamType.lightestColor,
        appBar: CustomAppBar(
          backgroundColor: widget.streamType.regularColor,
          textTheme: widget.streamType.appBarTextTheme,
          title: LocalizedTexts.assignment.tr(),
          subtitle: LocalizedTexts.introduction.tr(),
          leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: BlocBuilder<AssignmentsBloc, AssignmentsState>(
              builder: (context, state) {
                return state.maybeMap(
                  loading: (_) => const Loader(),
                  orElse: () => const SizedBox.shrink(),
                  updated: (s) {
                    final questions = s.data.questionsForLesson(widget.lessonId);
                    questionId = questions.first.id.toString();
                    questionTitle = questions.first.title;

                    AnalyticsEventService.instance.userOpenedAssignment(questions.first);

                    return MainContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 30.0),
                              SizedBox(
                                height: 365,
                                child: NetworkImageWithCache(url: questions.first.visual ?? ''),
                              ),
                              const SizedBox(height: 30.0),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CategoryLabel.assignment(),
                              const SizedBox(height: 18.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText.bitter600(
                                    questions.isNotEmpty ? questions.first.title : '',
                                    style: context.textTheme.displayLarge,
                                  ),
                                  const SizedBox(height: 18.0),
                                  CustomText.w400(
                                    questions.isNotEmpty ? questions.first.instruction : '',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18.0),
                              CustomOutlinedButton.blueSmall(
                                onPressed: () => _seeLessonBtnPressed(context),
                                label: LocalizedTexts.seeLesson.tr(),
                              ),
                              const SizedBox(height: 18.0),
                            ],
                          ),
                          Column(
                            children: [
                              CustomElevatedButton.blueFullWidth(
                                onPressed: _onStart,
                                label: LocalizedTexts.letsGo.tr(),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
