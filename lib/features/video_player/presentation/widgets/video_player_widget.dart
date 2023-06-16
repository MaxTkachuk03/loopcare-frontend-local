import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/video_player/presentation/video_page.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/player_end_video_overlay.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/player_overlay.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/video_block.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final Orientation orientation;
  final Exercise exercise;
  final VoidCallback onVideoEnds;
  final CountDownController countDownController;
  final String programType;
  final String programDifficulty;
  final int programLength;

  const VideoPlayerWidget({
    super.key,
    required this.controller,
    required this.orientation,
    required this.exercise,
    required this.onVideoEnds,
    required this.countDownController,
    required this.programType,
    required this.programDifficulty,
    required this.programLength,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  static const Duration _timerDuration = Duration(seconds: 3);
  static const Duration _animationDuration = Duration(milliseconds: 350);

  Timer? _timer;
  bool _showControls = false;

  void _showVideoControlsWithTimer() {
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
    return GestureDetector(
      onTap: _showVideoControlsWithTimer,
      child: Stack(
        fit: StackFit.expand,
        children: [
          VideoBlock(controller: widget.controller, orientation: widget.orientation),
          ValueListenableBuilder(
              valueListenable: widget.controller,
              builder: (BuildContext context, VideoPlayerValue value, child) {
                final videoFinished = value.isInitialized && value.position == value.duration;

                return videoFinished
                    ? PlayerEndVideoOverlay(
                        controller: widget.controller,
                        orientation: widget.orientation,
                        exercise: widget.exercise,
                        onVideoEnds: widget.onVideoEnds,
                        countDownController: widget.countDownController,
                        programType: widget.programType,
                        programDifficulty: widget.programDifficulty,
                        programLength: widget.programLength,
                      )
                    : AnimatedOpacity(
                        duration: _animationDuration,
                        opacity: _showControls ? 1 : 0,
                        child: Visibility(
                          visible: _showControls,
                          child: PlayerOverlay(
                            controller: widget.controller,
                            orientation: widget.orientation,
                            exercise: widget.exercise,
                            programType: widget.programType,
                            programDifficulty: widget.programDifficulty,
                            onSliderProgressChange: _showVideoControlsWithTimer,
                          ),
                        ),
                      );
              }),
        ],
      ),
    );
  }
}
