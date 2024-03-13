import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/rive_animation_renderer/rive_animation_renderer.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/subtitle/image_subtitle_controller.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/utils/get_label_by_category.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/audio_block.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/image_subtitles.dart';

const kHeightPadding = 20.0;

class LessonAudioBody extends StatefulWidget {
  final void Function() onNextPressed;
  final void Function() onPrevPressed;

  const LessonAudioBody({
    super.key,
    required this.onNextPressed,
    required this.onPrevPressed,
  });

  @override
  State<LessonAudioBody> createState() => _LessonAudioBodyState();
}

class _LessonAudioBodyState extends State<LessonAudioBody> {
  final SubtitleController _subtitleController = SubtitleController();

  late int lessonId;

  bool isPlay = false;

  @override
  void initState() {
    super.initState();

    final state = context.read<EducationLessonBloc>().state.data;

    context
        .read<EducationLessonBloc>()
        .add(EducationLessonEvent.downloadAudioFile(state.currentPage.content.url));

    if (state.currentPage.content.subtitlesImages != null) {
      context
          .read<EducationLessonBloc>()
          .add(EducationLessonEvent.downloadSubtitlesFile(state.currentPage.content.subtitlesImages!));
    }
  }

  _setIsComplete() {
    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            FirebaseEvents.lessonAudioFinished,
            {
              CustomDefinitions.lessonId: lessonId.toString(),
              CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

    AnalyticsEventService.instance.lessonAudioFinishedEvent(lessonId);
    widget.onNextPressed();
  }

  _setIsPlay(bool state) {
    setState(() {
      isPlay = state;
    });
  }

  void onCompleteModalHandler() {
    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            FirebaseEvents.closedTextLessonVersion,
            {
              CustomDefinitions.lessonId: lessonId.toString(),
              CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

    AnalyticsEventService.instance.closedTextLessonVersionEvent(lessonId);
  }

  void _onReadText() {
    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            FirebaseEvents.openedTextLessonVersion,
            {
              CustomDefinitions.lessonId: lessonId.toString(),
              CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

    AnalyticsEventService.instance.openedTextLessonVersionEvent(lessonId);

    ModalBottomSheet.readTextVersion(
      context: context,
      onBtnPress: widget.onNextPressed,
      onCompleteModal: onCompleteModalHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationLessonBloc, EducationLessonState>(
      builder: (context, state) {
        lessonId = state.data.lessonId;

        return CustomScaffold.petrolLightest(
          appBar: CustomAppBar.petrol(
            title: LocalizedTexts.lesson.tr(),
            leading: CustomFilledIconButton.leadingPetrolLighter(onPressed: widget.onPrevPressed),
          ),
          body: SafeArea(
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
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
                          children: [
                            const SizedBox(height: kHeightPadding),
                            Flexible(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      AnimatedOpacity(
                                        opacity: isPlay ? 0.0 : 1.0,
                                        duration: const Duration(milliseconds: 300),
                                        child: SizedBox(
                                            height: (constraints.maxHeight) / 2 - kHeightPadding,
                                            child: NetworkImageWithCache(url: state.data.lessonImage)),
                                      ),
                                      if (state.data.currentPage.content.subtitleFilePath.isNotEmpty)
                                        AnimatedOpacity(
                                          opacity: isPlay ? 1.0 : 0.0,
                                          duration: const Duration(milliseconds: 300),
                                          child: SizedBox(
                                            height: (constraints.maxHeight) / 2 - kHeightPadding,
                                            child: ImageSubtitles(controller: _subtitleController),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 17),
                                getLabelByCategory(state.data.lessonCategory),
                                const SizedBox(height: 17),
                                CustomText.bitter600(
                                  state.data.lessonTitle,
                                  style: context.textTheme.displayLarge,
                                ),
                                const SizedBox(height: 17),
                                CustomOutlinedButton.blueSmall(
                                  onPressed: _onReadText,
                                  label: LocalizedTexts.readText,
                                ),
                                if (state.data.currentPage.content.audioFilePath.isNotEmpty)
                                  AudioBlock(
                                    url: state.data.currentPage.content.audioFilePath,
                                    duration: state.data.lessonDuration,
                                    controller: _subtitleController,
                                    onPlayingChanged: _setIsPlay,
                                    onPlayerComplete: _setIsComplete,
                                  ),
                                const SizedBox(height: 14),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _subtitleController.dispose();

    super.dispose();
  }
}
