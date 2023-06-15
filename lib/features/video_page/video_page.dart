import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/video_player_widget/video_player_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class Exercise {
  final String name;
  final String image;
  final String video;
  final bool isCustom;
  final int order;
  final String duration;

  const Exercise(this.name, this.image, this.video, this.isCustom, this.order, this.duration);
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

const ex1 = Exercise(
    'Lunges',
    '',
    'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8',
    false,
    1,
    "1m 11s");
const ex2 = Exercise(
    'Elevated pushups',
    '',
    'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8',
    false,
    2,
    "45s");
const ex3 = Exercise(
    'Superman',
    '',
    'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.mp4/.m3u8',
    false,
    3,
    "1m 1s");
const ex4 = Exercise('Hollow hold', '', 'https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8',
    false, 4, "44s");

const program = Program(1, 'Body weight essentials', 'strength', 'easy', 'outdoor', 900, "Lunges description",
    "full body", "none", false, [ex1, ex2, ex3, ex4], null);

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Program _program = program;
  int _videoIndex = 0;
  late VideoPlayerController _controller;

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

  _setupVideoPlayer(Exercise exercise) {
    _controller = VideoPlayerController.network(exercise.video)
      ..initialize().then((_) {
        print(_controller.value.duration);
        setState(() {});
      });
  }

  @override
  void initState() {
    _allowLandscapeOrientation();

    _setupVideoPlayer(_program.exercises[_videoIndex]);

    super.initState();
  }

  @override
  void dispose() {
    _onlyPortraitOrientation();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          style:
                              TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.white),
                          textAlign: TextAlign.center,
                        ).tr(),
                      ],
                    ),
                  ),
                ),
              Expanded(child: VideoPlayerWidget(controller: _controller, orientation: orientation)),
              if (isPortrait)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 186,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                              ),
                          child: const Text(LocalizedTexts.skipExplanation).tr(),
                        ),
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
  }
}
