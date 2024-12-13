import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/lesson_audio_body.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/lesson_text_body.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class LessonPage extends StatefulWidget {
  final int lessonId;
  final RiverModuleStreamType streamType;

  const LessonPage({
    super.key,
    @PathParam('lessonId') required this.lessonId,
    this.streamType = RiverModuleStreamType.community,
  });

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  late EducationLessonData educationLessonBlocStateData;
  late AnalyticsBloc analyticsBloc;
  final usageAnalytics = UsageAnalytics();

  @override
  void initState() {
    super.initState();
    educationLessonBlocStateData = context.read<EducationLessonBloc>().state.data;
    analyticsBloc = context.read<AnalyticsBloc>();
    final riverModule = context.read<RiverBloc>().state.data.activeModule;

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.lessonOpened,
      attributes: {
        UsageAnalyticsAttributes.articleId: educationLessonBlocStateData.id,
        UsageAnalyticsAttributes.articleTitle: educationLessonBlocStateData.title,
        UsageAnalyticsAttributes.articlePool: riverModule?.title,
      },
    );
  }

  void _onNextPressed() {
    final lessonBlocData = context.read<EducationLessonBloc>().state.data;

    if (lessonBlocData.hasQuiz) {
      context.router.push(QuizIntroRoute(lessonId: widget.lessonId, streamType: widget.streamType));
    } else {
      context.router.push(LessonCompleteRoute(streamType: widget.streamType));
    }
  }

  void _onRetryHandler() => context
      .read<EducationLessonBloc>()
      .add(EducationLessonEvent.getLessonContent(lessonId: widget.lessonId));

  void _onContentLoaded(BuildContext context, EducationLessonState s) {
    final state = s.data;

    const AnalyticsEventService().logLessonEvent(
      AnalyticsEvents.lessonScreen,
      widget.lessonId,
      state.contentType,
      state.title,
      state.hasQuiz,
    );
  }

  @override
  void dispose() {
    super.dispose();

    analyticsBloc.add(
      AnalyticsEvent.sendAnalytics(
        AnalyticsEvents.leaveLessonScreen,
        {
          AnalyticsParameters.lessonId: widget.lessonId.toString(),
          AnalyticsParameters.lessonType: educationLessonBlocStateData.contentType.name,
          AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        },
      ),
    );

    const AnalyticsEventService().logLessonEvent(
      AnalyticsEvents.leaveLessonScreen,
      widget.lessonId,
      educationLessonBlocStateData.contentType,
      educationLessonBlocStateData.title,
      educationLessonBlocStateData.hasQuiz,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      color: widget.streamType.lightestColor,
      appBar: CustomAppBar(
        backgroundColor: widget.streamType.regularColor,
        title: LocalizedTexts.lesson.tr(),
        textTheme: widget.streamType.appBarTextTheme,
        leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
      ),
      body: CustomSafeArea(
        child: BlocConsumer<EducationLessonBloc, EducationLessonState>(
          listener: _onContentLoaded,
          listenWhen: (prev, cur) => cur is ContentLoaded,
          builder: (context, state) {
            return state.maybeMap(
              initial: (_) => const Loader(),
              contentIsLoading: (_) => const Loader(),
              errorGettingContent: (s) =>
                  ErrorScreen(error: s.data.error!, onButtonPressed: _onRetryHandler),
              orElse: () {
                if (state.data.isArticlePage) {
                  return LessonTextBody(
                    onNextPressed: _onNextPressed,
                    streamType: widget.streamType,
                  );
                }

                if (state.data.isAudioPage) {
                  return LessonAudioBody(
                    onNextPressed: _onNextPressed,
                    streamType: widget.streamType,
                  );
                }

                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
