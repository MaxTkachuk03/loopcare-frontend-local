import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
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
      final unlockedFeatures = getIt<SharedStorageService>().account?.unlockedFeatures ?? [];

      if (extraAction == ExtraActionTypes.setupGroupingPreferences &&
          !unlockedFeatures.contains(UnlockedFeatureType.grouping)) {

        context.read<AuthenticationBloc>().add(const AuthenticationEvent.unlockFeature(UnlockedFeatureType.grouping));

        AnalyticsEventService.instance.logEvent(FirebaseEvents.unlockedSupportGroupFeature);

        context
          ..read<GroupPreferencesBloc>()
              .add(const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.groupingLesson))
          ..router.pushNamed(AppRoutes.supportGroupIntro);

        return;
      }

      if (extraAction == ExtraActionTypes.unlockMeals &&
          !unlockedFeatures.contains(UnlockedFeatureType.meals)) {
        context.read<AuthenticationBloc>().add(const AuthenticationEvent.unlockFeature(UnlockedFeatureType.meals));
        context.router.pushNamed(AppRoutes.lessonCompleteFoodPreferences);

        return;
      }

      if (extraAction == ExtraActionTypes.unlockPhysicalActivities &&
          !unlockedFeatures.contains(UnlockedFeatureType.physicalActivities)) {
        context.read<AuthenticationBloc>().add(const AuthenticationEvent.unlockFeature(UnlockedFeatureType.physicalActivities));
        context.router.pushNamed(AppRoutes.physicalPreferencesIntro);

        return;
      }

      if (extraAction == ExtraActionTypes.unlockAssignments) {
        context.read<AuthenticationBloc>().add(const AuthenticationEvent.unlockFeature(UnlockedFeatureType.assignments));
      }
//Todo && !unlockedFeatures.contains(UnlockedFeatureType.buddy)
      if (lessonBlocData.isBuddyUnlocked) {
        context
          ..read<AuthenticationBloc>().unlockFeature(UnlockedFeatureType.buddy)
          ..router.pushNamed(AppRoutes.buddyIntro);
      }

      if (lessonBloc.state.data.questions.isEmpty ||
          lessonBloc.state.data.questions.first.type != LessonQuestionType.quiz) {
        context.router.pushNamed(AppRoutes.lessonComplete);
      } else {
        context.router.push(QuizzesIntroRoute(lessonId: widget.lessonId));
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

  void _onRetryHandler() => context
      .read<EducationLessonBloc>()
      .add(EducationLessonEvent.getLessonContent(lessonId: widget.lessonId, pageIndex: widget.pageIndex));

  void _onContentLoaded(BuildContext context, EducationLessonState s) {
    final state = s.data;

    AnalyticsEventService.instance.logLessonEvent(
      FirebaseEvents.lessonScreen,
      widget.lessonId,
      state.currentPage,
      state.lessonTitle,
      state.questions.isNotEmpty && state.questions.first.type == LessonQuestionType.quiz,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: CustomScaffold.petrolLightest(
        appBar: CustomAppBar.petrol(
          title: LocalizedTexts.lesson.tr(),
          leading: CustomFilledIconButton.leadingPetrolLighter(onPressed: _onPrevPressed),
        ),
        body: SafeArea(
          child: BlocConsumer<EducationLessonBloc, EducationLessonState>(
            listener: _onContentLoaded,
            listenWhen: (prev, cur) => cur is ContentLoaded,
            builder: (BuildContext context, state) {
              return state.maybeMap(
                initial: (_) => const Loader(),
                contentIsLoading: (_) => const Loader(),
                errorGettingContent: (s) =>
                    ErrorScreen(error: s.data.error!, onButtonPressed: _onRetryHandler),
                orElse: () {
                  if (state.data.isArticlePage) {
                    return LessonTextBody(
                        onNextPressed: _onNextPressed, content: state.data.currentPage.content);
                  }

                  if (state.data.isAudioPage) {
                    return LessonAudioBody(onNextPressed: _onNextPressed);
                  }

                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
