import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/system_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/aws_cookies_type.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/video_player/application/video_player_bloc.dart';
import 'package:loopcare_frontend/features/video_player/infrastructure/video_page_controller.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/rotate_device_message.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/video_player_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

@RoutePage()
class VideoPage extends StatefulWidget {
  final PhysicalProgram program;

  const VideoPage({super.key, required this.program});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  int _videoIndex = 0;

  VideoPlayerController? _videoPlayerController;
  final CountDownController _countDownController = CountDownController();
  late VideoPageController _videoPageController;

  bool get _isLastExercise => _videoIndex + 1 == widget.program.exercises.length;

  Future _allowLandscapeOrientation() async {
    await WakelockPlus.enable();

    SystemService.hideSystemOverlays();
    SystemService.allowBothOrientations();
  }

  Future _onlyPortraitOrientation() async {
    await WakelockPlus.disable();

    SystemService.showSystemOverlays();
    SystemService.allowOnlyPortraitOrientation();
  }

  void _initController(PhysicalProgramExercise exercise) async {
    final headers = context.read<VideoPlayerBloc>().state.data.videoHttpHeaders;

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(exercise.video ?? ''),
      httpHeaders: headers,
    )..initialize().then((value) {
        _videoPlayerController?.play();

        AnalyticsEventService().logPhysicalActivityVideoEvent(
          AnalyticsEvents.videoScreen,
          widget.program,
          exercise,
        );
      }).whenComplete(() {
        setState(() {});
      });
  }

  _loadVideoPlayer(PhysicalProgramExercise exercise) {
    if (_videoPlayerController == null) {
      _initController(exercise);
    } else {
      final oldController = _videoPlayerController;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController?.dispose();

        _initController(exercise);
      });

      setState(() {
        _videoPlayerController = null;
      });
    }
  }

  _onVideoEnds() {
    // check if it was the last video in playlist
    if (_isLastExercise) {
      _onlyPortraitOrientation();
      _videoPlayerController?.pause();
      context.router.push(ProgramAssessmentRoute(onDisposeCb: _allowLandscapeOrientation));
      return;
    }

    _loadVideoPlayer(widget.program.exercises[_videoIndex + 1]);

    _videoPageController.setCountDownTimer(widget.program.exercises[_videoIndex].delayBeforeNext);

    setState(() {
      _videoIndex += 1;
    });
  }

  _onPrevPressed() {
    // check if it is the first video in playlist
    if (_videoIndex == 0) return;

    _loadVideoPlayer(widget.program.exercises[_videoIndex - 1]);

    _videoPageController
        .setCountDownTimer(widget.program.exercises[_videoIndex - 1].delayBeforeNext);

    setState(() {
      _videoIndex -= 1;
    });
  }

  @override
  void initState() {
    _allowLandscapeOrientation();

    _videoPageController = VideoPageController(
      countDownController: _countDownController,
      defaultCountDownValue: widget.program.exercises[_videoIndex].delayBeforeNext,
    )..setCountDownTimer(widget.program.exercises[_videoIndex].delayBeforeNext);

    context.read<VideoPlayerBloc>().add(const VideoPlayerEvent.getAwsCookies(AwsCookiesType.MAIN));

    super.initState();
  }

  _onSkipExplanationHandler() {
    final controller = _videoPlayerController;

    if (controller == null) return;

    final skipTime = widget.program.exercises[_videoIndex].explanationSkipTime;

    if (controller.value.position.inSeconds >= skipTime) return;

    _videoPlayerController?.seekTo(Duration(seconds: skipTime));
  }

  Future<bool> _onWillPop(BuildContext context) {
    AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.programClosed,
      parameters: {
        AnalyticsParameters.programId: widget.program.id,
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final controller = _videoPlayerController;
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: BlocConsumer<VideoPlayerBloc, VideoPlayerState>(
        listenWhen: (prev, cur) => cur is CookiesLoaded,
        listener: _cookiesLoadedListener,
        builder: (BuildContext context, state) {
          return state.maybeMap(
            loading: (_) => const Loader(),
            orElse: () => const SizedBox.shrink(),
            cookiesLoaded: (s) {
              return OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
                final bool isPortrait = orientation == Orientation.portrait;

                _videoPageController.setOrientation(orientation);

                return CustomScaffold.blueDarkest(
                  appBar: isPortrait
                      ? CustomAppBar.transparent(
                          leading: CustomFilledIconButton.leadingBlueLighter())
                      : null,
                  body: CustomSafeArea(
                    bottom: isPortrait,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (isPortrait) const Expanded(child: RotateDeviceMessage()),
                        Expanded(
                          child: VideoPlayerWidget(
                            controller: controller,
                            orientation: orientation,
                            isLastVideo: _isLastExercise,
                            programType: widget.program.typeName,
                            programDifficulty: widget.program.difficultyName,
                            programLength: widget.program.exercises.length,
                            exercise: widget.program.exercises[_videoIndex],
                            onVideoEnds: _onVideoEnds,
                            onPrevPressed: _videoIndex == 0 ? null : _onPrevPressed,
                            countDownController: _countDownController,
                            videoPageController: _videoPageController,
                          ),
                        ),
                        if (isPortrait)
                          Expanded(
                            child: controller != null
                                ? ValueListenableBuilder(
                                    valueListenable: controller,
                                    builder: (BuildContext context, VideoPlayerValue value, child) {
                                      final bool isVisible = value.position.inSeconds <
                                          widget.program.exercises[_videoIndex].explanationSkipTime;

                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                            visible: isVisible,
                                            child: CustomElevatedButton.yellow(
                                              onPressed: _onSkipExplanationHandler,
                                              label: LocalizedTexts.skipExplanation.tr(),
                                            ),
                                          ),
                                          const SizedBox(height: 30.0),
                                        ],
                                      );
                                    },
                                  )
                                : const SizedBox.shrink(),
                          ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }

  _cookiesLoadedListener(BuildContext context, VideoPlayerState state) {
    _loadVideoPlayer(widget.program.exercises[_videoIndex]);
  }

  _disposeVideoController() {
    final controller = _videoPlayerController;

    if (controller == null) return;

    if (controller.value.isPlaying) _videoPlayerController?.pause();

    controller.dispose();
  }

  @override
  void dispose() {
    _onlyPortraitOrientation();

    _disposeVideoController();

    _videoPageController.dispose();

    super.dispose();
  }
}
