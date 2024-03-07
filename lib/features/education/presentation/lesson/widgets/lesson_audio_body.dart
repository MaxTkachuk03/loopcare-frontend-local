import 'dart:io' as i;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
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
import 'package:loopcare_frontend/injection.dart';

const kHeightPadding = 20.0;

// TODO refactor _subtitleController
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
  AppConfig appConfig = getIt<AppConfig>();
  late SubtitleController _subtitleController;
  bool _subtitleControllerInitialized = false;

  String? imageUrl;
  String? imageUrlFromJson;
  late int lessonId;

  int position = 0;
  int duration = 0;
  bool isPlay = false;
  bool isSvg = false;

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

  prepareSubtitleController(String path) async {
    final i.File file = i.File(path);
    final subtitleFile = await file.readAsString();

    _subtitleController = SubtitleController.string(subtitleFile);
    _subtitleControllerInitialized = true;
  }

  _setDuration(int v) {
    setState(() {
      duration = v;
    });
  }

  _setPosition(int v) {
    setState(() {
      position = v;
    });

    if (duration > 0 && _subtitleControllerInitialized) {
      String text = _subtitleController.textFromMilliseconds(
        position,
        _subtitleController.subtitles,
      );
      if (text.isNotEmpty && imageUrlFromJson != text) {
        setState(() {
          imageUrl = "${appConfig.baseUrl}/education/content/$lessonId/$text";
          imageUrlFromJson = text;
          if (text.contains('.svg')) {
            context.read<EducationLessonBloc>().add(EducationLessonEvent.downloadSVGFile(imageUrl!));
            isSvg = true;
          } else {
            isSvg = false;
          }
        });
      } else if (text.isEmpty) {
        setState(() {
          imageUrl = null;
          imageUrlFromJson = text;
        });
      }
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
        if (state.data.currentPage.content.subtitleFilePath.isNotEmpty) {
          prepareSubtitleController(state.data.currentPage.content.subtitleFilePath);
        }
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
                  child: MainContainer(
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
                                  // TODO 18.01.2024 sync with Diana, decided to remove subtitle images logic for now
                                  // AnimatedOpacity(
                                  //   opacity: isPlay ? 0.0 : 1.0,
                                  //   duration: const Duration(milliseconds: 300),
                                  //   child: SizedBox(
                                  //     height: 410,
                                  //     child: imageUrl != null && imageUrl != ''
                                  //         ? isSvg
                                  //             ? state.data.isSvgLoaded
                                  //                 ? SvgPicture.file(i.File(state.data.svgFile))
                                  //                 : null
                                  //             : NetworkImageWithCache(
                                  //                 withPlaceholder: false,
                                  //                 url: imageUrl!,
                                  //                 imageBoxFit: BoxFit.contain,
                                  //               )
                                  //         : null,
                                  //   ),
                                  // ),
                                  AnimatedOpacity(
                                    opacity: isPlay ? 0.0 : 1.0,
                                    duration: const Duration(milliseconds: 300),
                                    child: SizedBox(
                                        height: (constraints.maxHeight) / 2 - kHeightPadding,
                                        child: NetworkImageWithCache(url: state.data.lessonImage)),
                                  ),
                                  AnimatedOpacity(
                                    opacity: isPlay ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 300),
                                    child: SizedBox(
                                      height: (constraints.maxHeight) / 2 - kHeightPadding,
                                      child: const RiveAnimationRenderer(),
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
                                onDurationChanged: _setDuration,
                                onPositionChanged: _setPosition,
                                onPlayingChanged: _setIsPlay,
                                onPlayerComplete: _setIsComplete,
                              ),
                            const SizedBox(height: 14),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
