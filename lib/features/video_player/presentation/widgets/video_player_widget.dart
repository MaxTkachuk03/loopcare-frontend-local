import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/video_player/presentation/video_page.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/player_end_video_overlay.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/player_overlay.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final Orientation orientation;
  final Exercise exercise;
  final VoidCallback onVideoEnds;
  final CountDownController countDownController;
  final String programType;
  final String programDifficulty;
  final int programLenght;

  const VideoPlayerWidget({
    super.key,
    required this.controller,
    required this.orientation,
    required this.exercise,
    required this.onVideoEnds,
    required this.countDownController,
    required this.programType,
    required this.programDifficulty,
    required this.programLenght,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  static const Duration _timerDuration = Duration(seconds: 3);
  static const Duration _animationDuration = Duration(milliseconds: 350);

  Timer? _timer;
  bool _showControls = false;

  _onVideoPressedHandler() {
    if (_timer != null) _timer?.cancel();

    _timer = Timer.periodic(_timerDuration, (timer) {
      setState(() {
        _showControls = false;
      });

      timer.cancel();
    });

    setState(() {
      _showControls = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.value.isInitialized
        ? GestureDetector(
            onTap: _onVideoPressedHandler,
            child: Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: widget.controller.value.size.width,
                    height: widget.controller.value.size.height,
                    child: AspectRatio(
                      aspectRatio: widget.controller.value.aspectRatio,
                      child: VideoPlayer(widget.controller),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: widget.controller,
                    builder: (BuildContext context, VideoPlayerValue value, child) {
                      final videoFinished = value.position == value.duration;

                      return videoFinished
                          ? PlayerEndVideoOverlay(
                              controller: widget.controller,
                              orientation: widget.orientation,
                              exercise: widget.exercise,
                              onVideoEnds: widget.onVideoEnds,
                              countDownController: widget.countDownController,
                              programType: widget.programType,
                              programDifficulty: widget.programDifficulty,
                              programLenght: widget.programLenght,
                            )
                          : AnimatedOpacity(
                              duration: _animationDuration,
                              opacity: _showControls ? 1 : 0,
                              child: PlayerOverlay(
                                controller: widget.controller,
                                orientation: widget.orientation,
                                exercise: widget.exercise,
                                programType: widget.programType,
                                programDifficulty: widget.programDifficulty,
                                programLenght: widget.programLenght,
                              ),
                            );
                    }),
              ],
            ),
          )
        : const Center(child: Loader());
  }
}
