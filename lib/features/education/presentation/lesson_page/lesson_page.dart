import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';

import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson_page_type.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/lesson_audio_body.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/lesson_text_body.dart';

class LessonPage extends StatefulWidget {
  final int lessonId;
  final int pageIndex;

  const LessonPage({
    Key? key,
    @PathParam('lessonId') required this.lessonId,
    @PathParam('pageIndex') required this.pageIndex,
  }) : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  _onNextPressed() {
    final lessonBloc = context.read<EducationLessonBloc>();

    lessonBloc.add(const EducationLessonEvent.nextPage());

    lessonBloc.add(const EducationLessonEvent.progressForward());

    if (lessonBloc.state.data.isLastPage) {
      final extraAction = lessonBloc.state.data.extraAction;
      final unlockedFeatures = context.read<AuthenticationCubit>().state.unlockedFeatures;

      if (extraAction == ExtraActionTypes.setupGroupingPreferences &&
          !unlockedFeatures.contains(UnlockedFeatureType.grouping)) {
        context
          ..read<GroupPreferencesBloc>()
              .add(const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.groupingLesson))
          ..router.pushNamed(AppRoutes.supportGroupIntro);

        return;
      }

      if (extraAction == ExtraActionTypes.unlockMeals) {
        context.read<AuthenticationCubit>().unlockFeature(UnlockedFeatureType.meals);
      }

      if (extraAction == ExtraActionTypes.unlockPhysicalActivities &&
          !unlockedFeatures.contains(UnlockedFeatureType.physicalActivities)) {
        context.router.pushNamed(AppRoutes.physicalActivitiesPreferences);

        return;
      }

      context.router.pushNamed(AppRoutes.lessonComplete);

      return;
    }

    int pageIndex = widget.pageIndex + 1;

    context.router.pushNamed('/lesson/${widget.lessonId}/page/$pageIndex');
  }

  _onPrevPressed() {
    context.read<EducationLessonBloc>().add(const EducationLessonEvent.prevPage());
    context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressBack());

    context.router.pop();
  }

  _errorListener(BuildContext context, EducationLessonState state) {
    showAppSnackBar(
      context: context,
      text: 'Something went wrong, try again',
      background: AppColors.red,
      textColor: Colors.white,
    );
    context.router.pop();
  }

  Future<bool> _onWillPop() {
    final lessonType = context.read<EducationLessonBloc>().state.data.currentPage.type.name;
    final userId = context.read<AuthenticationCubit>().state.id;

    context.read<AnalyticsBloc>().add(AnalyticsEvent.sendAnalytics(AnalyticsEvents.leaveLessonScreen, {
          "lessonId": widget.lessonId.toString(),
          "lessonType": lessonType,
          "timestamp": DateTime.now().toIso8601String(),
        }));

    AnalyticsEventService.instance.leaveLessonEvent(
      widget.lessonId,
      lessonType,
      userId,
    );

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocConsumer<EducationLessonBloc, EducationLessonState>(
        listenWhen: (prev, cur) => cur is ErrorGettingLessons,
        listener: _errorListener,
        builder: (BuildContext context, state) {
          return state.maybeMap(
            loading: (_) => const Loader(),
            contentLoaded: (s) {
              final currentPage = s.data.currentPage;
              final userId = context.read<AuthenticationCubit>().state.id;

              AnalyticsEventService.instance.logLessonEvent(
                'lesson_screen',
                widget.lessonId,
                currentPage,
                userId,
              );

              if (currentPage.type == EducationLessonPageType.text) {
                return LessonTextPage(
                  onNextPressed: _onNextPressed,
                  onPrevPressed: _onPrevPressed,
                  content: currentPage.content,
                );
              }
              if (currentPage.type == EducationLessonPageType.audio) {
                if (state.data.temporaryDirectory.isEmpty) {
                  context.read<EducationLessonBloc>().add(const EducationLessonEvent.init());
                }
                if (!state.data.isLoading &&
                    state.data.currentPage.type == EducationLessonPageType.audio &&
                    state.data.currentPage.content.audioFilePath.isEmpty) {
                  context.read<EducationLessonBloc>().add(
                        EducationLessonEvent.downloadAudioFile(state.data.currentPage.content.url),
                      );
                }
                if (!state.data.isLoading &&
                    state.data.currentPage.type == EducationLessonPageType.audio &&
                    state.data.currentPage.content.subtitlesImages != null &&
                    state.data.currentPage.content.subtitleFilePath.isEmpty) {
                  context.read<EducationLessonBloc>().add(
                        EducationLessonEvent.downloadSubtitlesFile(
                            state.data.currentPage.content.subtitlesImages!),
                      );
                }
                return LessonAudioPage(
                  onNextPressed: _onNextPressed,
                  onPrevPressed: _onPrevPressed,
                );
              }
              return const SizedBox.shrink();
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
