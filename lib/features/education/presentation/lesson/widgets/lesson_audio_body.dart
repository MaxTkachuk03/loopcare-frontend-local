import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/rive_animation_renderer/rive_animation_renderer.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/subtitle/image_subtitle_controller.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/audio_block.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/image_container.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/player_loading_state.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/get_label_by_stream_type.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

const kHeightPadding = 20.0;

class LessonAudioBody extends StatefulWidget {
  final RiverModuleStreamType streamType;
  final void Function() onNextPressed;

  const LessonAudioBody({super.key, required this.onNextPressed, required this.streamType});

  @override
  State<LessonAudioBody> createState() => _LessonAudioBodyState();
}

class _LessonAudioBodyState extends State<LessonAudioBody> {
  final SubtitleController _subtitleController = SubtitleController();

  late int lessonId;

  @override
  void initState() {
    super.initState();

    final state = context.read<EducationLessonBloc>().state.data;

    lessonId = state.id;

    context.read<EducationLessonBloc>().add(EducationLessonEvent.downloadAudioFile(state.audioUrl));

    if (state.subtitleImages != null) {
      context
          .read<EducationLessonBloc>()
          .add(EducationLessonEvent.downloadSubtitlesFile(state.subtitleFilePath));
    }
  }

  _setIsComplete() {
    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            AnalyticsEvents.lessonAudioFinished,
            {
              AnalyticsParameters.lessonId: lessonId.toString(),
              AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

    const AnalyticsEventService().lessonAudioFinishedEvent(lessonId);
    widget.onNextPressed();
  }

  void onCompleteModalHandler() {
    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            AnalyticsEvents.closedTextLessonVersion,
            {
              AnalyticsParameters.lessonId: lessonId.toString(),
              AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

    const AnalyticsEventService().closedTextLessonVersionEvent(lessonId);
  }

  void _onReadText() {
    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            AnalyticsEvents.openedTextLessonVersion,
            {
              AnalyticsParameters.lessonId: lessonId.toString(),
              AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

    const AnalyticsEventService().openedTextLessonVersionEvent(lessonId);

    ModalBottomSheet.readTextVersion(
      context: context,
      streamType: widget.streamType,
      onBtnPress: widget.onNextPressed,
      onCompleteModal: onCompleteModalHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return ScrollableContainer(
        child: ConstrainedBox(
          constraints: constraints.copyWith(
            maxHeight: constraints.maxHeight,
            maxWidth: constraints.maxWidth,
          ),
          child: Stack(
            children: [
              const RiveAnimationRenderer(),
              MainContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: kHeightPadding),
                    Flexible(
                      flex: 4,
                      child: ImageContainer(
                        controller: _subtitleController,
                        height: (constraints.maxHeight) / 2 - kHeightPadding,
                      ),
                    ),
                    BlocBuilder<EducationLessonBloc, EducationLessonState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 17),
                            getLabelByStreamType(widget.streamType),
                            const SizedBox(height: 17),
                            CustomText.bitter600(
                              state.data.title,
                              style: context.textTheme.displayLarge,
                            ),
                            const SizedBox(height: 17),
                            CustomOutlinedButton.blueSmall(
                              onPressed: _onReadText,
                              label: LocalizedTexts.readText.tr(),
                            ),
                            const PlayerLoadingState()
                                .animate(target: state.data.isAudioLoading ? 0 : 1)
                                .fadeOut(duration: 300.ms)
                                .swap(
                                  duration: 300.ms,
                                  builder: (_, __) => AudioBlock(
                                    url: state.data.audioFilePath,
                                    audioPreviewImage: state.data.cardImageUrl,
                                    duration: state.data.duration,
                                    title: state.data.title,
                                    controller: _subtitleController,
                                    onPlayerComplete: _setIsComplete,
                                  ).animate().fadeIn(duration: 300.ms),
                                ),
                            const SizedBox(height: 14),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _subtitleController.dispose();

    super.dispose();
  }
}
