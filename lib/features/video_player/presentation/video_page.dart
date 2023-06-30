import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/video_player/application/video_player_bloc.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/video_player_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoPage extends StatefulWidget {
  final PhysicalProgram program;

  const VideoPage({Key? key, required this.program}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  int _videoIndex = 0;

  VideoPlayerController? _videoPlayerController;
  final CountDownController _countDownController = CountDownController();

  bool get _isLastExercise => _videoIndex + 1 == widget.program.exercises.length;

  Future _allowLandscapeOrientation() async {
    // Remove system app bar on Android
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    await Wakelock.enable();

    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );
  }

  Future _onlyPortraitOrientation() async {
    // Restores system app bar on Android
    await SystemChrome.restoreSystemUIOverlays();

    await Wakelock.disable();

    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
    );
  }

  void _initController(PhysicalProgramExercise exercise) async {
    final headers = context.read<VideoPlayerBloc>().state.data.videoHttpHeaders;

    _videoPlayerController = VideoPlayerController.network(exercise.video ?? '', httpHeaders: headers)
      ..initialize().then((value) {
        _videoPlayerController?.play();
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

    setState(() {
      _videoIndex += 1;
    });
  }

  _onPrevPressed() {
    // check if it is the first video in playlist
    if (_videoIndex == 0) return;

    _loadVideoPlayer(widget.program.exercises[_videoIndex - 1]);

    setState(() {
      _videoIndex -= 1;
    });
  }

  @override
  void initState() {
    _allowLandscapeOrientation();

    context.read<VideoPlayerBloc>().add(const VideoPlayerEvent.getAwsCookies());

    super.initState();
  }

  _onSkipExplanationHandler() {
    final controller = _videoPlayerController;

    if (controller == null) return;

    final skipTime = widget.program.exercises[_videoIndex].explanationSkipTime;

    if (controller.value.position.inSeconds >= skipTime) return;

    _videoPlayerController?.seekTo(Duration(seconds: skipTime));
  }

  @override
  Widget build(BuildContext context) {
    final controller = _videoPlayerController;
    return BlocConsumer<VideoPlayerBloc, VideoPlayerState>(
      listenWhen: (prev, cur) => cur is CookiesLoaded,
      listener: _cookiesLoadedListener,
      builder: (BuildContext context, state) {
        return state.maybeMap(
          loading: (_) => const Loader(),
          orElse: () => const SizedBox.shrink(),
          cookiesLoaded: (s) {
            return OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
              final bool isPortrait = orientation == Orientation.portrait;

              return Scaffold(
                backgroundColor: AppColors.black,
                appBar: isPortrait
                    ? AppBar(
                        backgroundColor: AppColors.black,
                        leading: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                          ),
                          onPressed: context.router.pop,
                        ))
                    : null,
                body: SafeArea(
                  bottom: isPortrait,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (isPortrait)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 38.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppIcons.telephone,
                                const SizedBox(height: 22.0),
                                const Text(
                                  LocalizedTexts.rotateDevice,
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.white),
                                  textAlign: TextAlign.center,
                                ).tr(),
                              ],
                            ),
                          ),
                        ),
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
                                          child: ElevatedButton(
                                            onPressed: _onSkipExplanationHandler,
                                            style: ButtonStyle(
                                              minimumSize: MaterialStateProperty.all(const Size(186, 52.0)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(AppColors.orangeDark),
                                            ),
                                            child: const Text(LocalizedTexts.skipExplanation).tr(),
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

    super.dispose();
  }
}
