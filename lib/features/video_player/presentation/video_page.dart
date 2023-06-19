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
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/video_player/application/video_player_bloc.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/video_player_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class Exercise {
  final String name;
  final String image;
  final String video;
  final int order;
  final int duration;
  final int delayBeforeNext;
  final int explanationSkipTime;

  const Exercise(this.name, this.image, this.video, this.order, this.duration, this.delayBeforeNext,
      this.explanationSkipTime);
}

class Program {
  final int id;
  final String name;
  final String type;
  final String difficulty;
  final String place;
  final int duration;
  final String programDescription;
  final String targetMuscles;
  final String equipment;
  final bool isCustom;
  final List<Exercise> exercises;
  final dynamic assessment;

  const Program(
    this.id,
    this.name,
    this.type,
    this.difficulty,
    this.place,
    this.duration,
    this.programDescription,
    this.targetMuscles,
    this.equipment,
    this.isCustom,
    this.exercises,
    this.assessment,
  );
}

const ex1 = Exercise('Lunges', '', 'https://d316h49i7nayz2.cloudfront.net/Lunges/index.m3u8', 1, 61, 5, 10);
const ex2 = Exercise(
    'Elevated pushups', '', 'https://d316h49i7nayz2.cloudfront.net/ElevatedPushups/index.m3u8', 2, 45, 3, 10);
const ex3 =
    Exercise('Superman', '', 'https://d316h49i7nayz2.cloudfront.net/Superman/index.m3u8', 3, 61, 7, 10);
const ex4 =
    Exercise('Hollow hold', '', 'https://d316h49i7nayz2.cloudfront.net/HollowHold/index.m3u8', 4, 44, 0, 10);

const program = Program(1, 'Body weight essentials', 'strength', 'easy', 'outdoor', 900, "Lunges description",
    "full body", "none", false, [ex1, ex2, ex3, ex4], null);

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final Program _program = program;

  int _videoIndex = 0;

  late VideoPlayerController _controller;
  final CountDownController _countDownController = CountDownController();

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

  _loadVideoPlayer(Exercise exercise) {
    final headers = context.read<VideoPlayerBloc>().state.data.videoHttpHeaders;

    _controller = VideoPlayerController.network(exercise.video, httpHeaders: headers)
      ..initialize().then((value) {
        _controller.play();
        setState(() {});
      });
  }

  _onVideoEnds() {
    // check if it was the last video in playlist
    if (_videoIndex + 1 == _program.exercises.length) {
      // TODO do redirect to the evaluation screen
      return;
    }

    if (_controller.value.isPlaying) _controller.pause();

    _loadVideoPlayer(_program.exercises[_videoIndex + 1]);

    setState(() {
      _videoIndex += 1;
    });
  }

  _onPrevPressed() {
    // check if it is the first video in playlist
    if (_videoIndex == 0) {
      return;
    }

    if (_controller.value.isPlaying) _controller.pause();

    _loadVideoPlayer(_program.exercises[_videoIndex - 1]);

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
    final skipTime = _program.exercises[_videoIndex].explanationSkipTime;

    if (_controller.value.position.inSeconds >= skipTime) return;

    _controller.seekTo(Duration(seconds: skipTime));
  }

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () => context.router.pop(),
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
                          controller: _controller,
                          orientation: orientation,
                          programType: _program.type,
                          programDifficulty: _program.difficulty,
                          programLength: _program.exercises.length,
                          exercise: _program.exercises[_videoIndex],
                          onVideoEnds: _onVideoEnds,
                          onPrevPressed: _onPrevPressed,
                          countDownController: _countDownController,
                        ),
                      ),
                      if (isPortrait)
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: _onSkipExplanationHandler,
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(const Size(186, 52.0)),
                                  backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                                ),
                                child: const Text(LocalizedTexts.skipExplanation).tr(),
                              ),
                              const SizedBox(height: 30.0),
                            ],
                          ),
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
    _loadVideoPlayer(_program.exercises[_videoIndex]);
  }

  @override
  void dispose() {
    _onlyPortraitOrientation();

    _countDownController.reset();

    super.dispose();
  }
}
