import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';

import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson_page_type.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/lesson_audio_body.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/lesson_text_body.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_type.dart';

class LessonPage extends StatefulWidget {
  final int lessonId;
  final int pageIndex;

  const LessonPage({
    super.key,
    @PathParam('lessonId') required this.lessonId,
    @PathParam('pageIndex') required this.pageIndex,
  });

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

      if (extraAction == ExtraActionTypes.unlockMeals &&
          !unlockedFeatures.contains(UnlockedFeatureType.meals)) {
        context.read<AuthenticationCubit>().unlockFeature(UnlockedFeatureType.meals);
        context.router.pushNamed(AppRoutes.lessonCompleteFoodPreferences);

        return;
      }

      if (extraAction == ExtraActionTypes.unlockPhysicalActivities &&
          !unlockedFeatures.contains(UnlockedFeatureType.physicalActivities)) {
        context.read<AuthenticationCubit>().unlockFeature(UnlockedFeatureType.physicalActivities);
        context.router.pushNamed(AppRoutes.physicalPreferencesIntro);

        return;
      }

      if (extraAction == ExtraActionTypes.unlockAssignments) {
        context.read<AuthenticationCubit>().unlockFeature(UnlockedFeatureType.assignments);
      }

      if (lessonBloc.state.data.questions.isEmpty ||
          lessonBloc.state.data.questions.first.type != LessonQuestionType.quiz) {
        context.router.pushNamed(AppRoutes.lessonComplete);
      } else {
        context.router.push(
          QuizzesIntroRoute(
            lessonId: widget.lessonId,
          ),
        );
      }

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
    final errorMessage = state.data.errorMessage ?? LocalizedTexts.somethingWentWrong.tr();
    context.showError(content: Text(errorMessage));
    context.router.pop();
  }

  Future<bool> _onWillPop() {
    final stateData = context.read<EducationLessonBloc>().state.data;

    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            FirebaseEvents.leaveLessonScreen,
            {
              CustomDefinitions.lessonId: widget.lessonId.toString(),
              CustomDefinitions.lessonType: stateData.currentPage.type.name,
              CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

    AnalyticsEventService.instance.logLessonEvent(
      FirebaseEvents.leaveLessonScreen,
      widget.lessonId,
      stateData.currentPage,
      stateData.lessonTitle,
      stateData.questions.isNotEmpty && stateData.questions.first.type == LessonQuestionType.quiz,
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
            loading: (_) => CustomScaffold.petrolLightest(
              appBar: CustomAppBar.petrol(
                title: LocalizedTexts.lesson.tr(),
                leading: CustomFilledIconButton.leadingPetrolLighter(),
              ),
              body: const Loader(),
            ),
            lessonCompleted: (s) {
              final currentPage = s.data.currentPage;

              if (currentPage.type == EducationLessonPageType.text) {
                return LessonTextBody(
                  onNextPressed: _onNextPressed,
                  onPrevPressed: _onPrevPressed,
                  content: currentPage.content,
                );
              }
              if (currentPage.type == EducationLessonPageType.audio) {
                if (state.data.temporaryDirectory.isEmpty) {
                  context.read<EducationLessonBloc>().add(const EducationLessonEvent.init());
                }
                if (!state.data.isAudioLoading &&
                    state.data.currentPage.type == EducationLessonPageType.audio &&
                    state.data.currentPage.content.audioFilePath.isEmpty) {
                  context.read<EducationLessonBloc>().add(
                        EducationLessonEvent.downloadAudioFile(state.data.currentPage.content.url),
                      );
                }
                if (!state.data.isSubtitleLoading &&
                    state.data.currentPage.type == EducationLessonPageType.audio &&
                    state.data.currentPage.content.subtitlesImages != null &&
                    state.data.currentPage.content.subtitleFilePath.isEmpty) {
                  context.read<EducationLessonBloc>().add(EducationLessonEvent.downloadSubtitlesFile(
                      state.data.currentPage.content.subtitlesImages!));
                }
                return LessonAudioBody(
                  onNextPressed: _onNextPressed,
                  onPrevPressed: _onPrevPressed,
                );
              }
              return const SizedBox.shrink();
            },
            contentLoaded: (s) {
              final currentPage = s.data.currentPage;

              AnalyticsEventService.instance.logLessonEvent(
                FirebaseEvents.lessonScreen,
                widget.lessonId,
                currentPage,
                s.data.lessonTitle,
                s.data.questions.isNotEmpty && s.data.questions.first.type == LessonQuestionType.quiz,
              );

              if (currentPage.type == EducationLessonPageType.text) {
                return LessonTextBody(
                  onNextPressed: _onNextPressed,
                  onPrevPressed: _onPrevPressed,
                  content: currentPage.content,
                );
              }
              if (currentPage.type == EducationLessonPageType.audio) {
                if (state.data.temporaryDirectory.isEmpty) {
                  context.read<EducationLessonBloc>().add(const EducationLessonEvent.init());
                }
                if (!state.data.isAudioLoading &&
                    state.data.currentPage.type == EducationLessonPageType.audio &&
                    state.data.currentPage.content.audioFilePath.isEmpty) {
                  context.read<EducationLessonBloc>().add(
                        EducationLessonEvent.downloadAudioFile(state.data.currentPage.content.url),
                      );
                }
                if (!state.data.isSubtitleLoading &&
                    state.data.currentPage.type == EducationLessonPageType.audio &&
                    state.data.currentPage.content.subtitlesImages != null &&
                    state.data.currentPage.content.subtitleFilePath.isEmpty) {
                  context.read<EducationLessonBloc>().add(
                        EducationLessonEvent.downloadSubtitlesFile(
                            state.data.currentPage.content.subtitlesImages!),
                      );
                }
                return LessonAudioBody(
                  onNextPressed: _onNextPressed,
                  onPrevPressed: _onPrevPressed,
                );
              }
              return const SizedBox.shrink();
            },
            errorCompleteLesson: (s) {
              final currentPage = s.data.currentPage;

              if (currentPage.type == EducationLessonPageType.text) {
                return LessonTextBody(
                  onNextPressed: _onNextPressed,
                  onPrevPressed: _onPrevPressed,
                  content: currentPage.content,
                );
              }
              if (currentPage.type == EducationLessonPageType.audio) {
                if (state.data.temporaryDirectory.isEmpty) {
                  context.read<EducationLessonBloc>().add(const EducationLessonEvent.init());
                }
                if (!state.data.isAudioLoading &&
                    state.data.currentPage.type == EducationLessonPageType.audio &&
                    state.data.currentPage.content.audioFilePath.isEmpty) {
                  context.read<EducationLessonBloc>().add(
                        EducationLessonEvent.downloadAudioFile(state.data.currentPage.content.url),
                      );
                }
                if (!state.data.isSubtitleLoading &&
                    state.data.currentPage.type == EducationLessonPageType.audio &&
                    state.data.currentPage.content.subtitlesImages != null &&
                    state.data.currentPage.content.subtitleFilePath.isEmpty) {
                  context.read<EducationLessonBloc>().add(
                        EducationLessonEvent.downloadSubtitlesFile(
                            state.data.currentPage.content.subtitlesImages!),
                      );
                }
                return LessonAudioBody(
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
