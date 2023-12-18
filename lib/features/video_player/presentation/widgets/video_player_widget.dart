import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/video_player/infrastructure/video_page_controller.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/player_end_video_overlay.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/player_overlay.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/video_block.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/video_error.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController? controller;
  final Orientation orientation;
  final PhysicalProgramExercise exercise;
  final VoidCallback onVideoEnds;
  final VoidCallback? onPrevPressed;
  final CountDownController countDownController;
  final bool isLastVideo;
  final String programType;
  final String programDifficulty;
  final int programLength;
  final VideoPageController videoPageController;

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
    required this.isLastVideo,
    required this.videoPageController,
    this.onPrevPressed,
  });

  Widget _errorWidgetCb(double width, double height, String? error) =>
      VideoError(width: width, height: height, errorMessage: error);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        VideoBlock(controller: controller, orientation: orientation, errorWidget: _errorWidgetCb),
        if (controller != null)
          ValueListenableBuilder(
            valueListenable: controller!,
            builder: (BuildContext context, VideoPlayerValue value, child) {
              final videoFinished = value.isInitialized && value.position >= value.duration;

              return videoFinished
                  ? PlayerEndVideoOverlay(
                      controller: controller!,
                      orientation: orientation,
                      exercise: exercise,
                      onVideoEnds: onVideoEnds,
                      isLastVideo: isLastVideo,
                      countDownController: countDownController,
                      programType: programType,
                      programDifficulty: programDifficulty,
                      programLength: programLength,
                      videoPageController: videoPageController,
                    )
                  : PlayerOverlay(
                      controller: controller!,
                      orientation: orientation,
                      exercise: exercise,
                      onPrevPressed: onPrevPressed,
                      onNextPressed: onVideoEnds,
                      programType: programType,
                      programDifficulty: programDifficulty,
                    );
            },
          ),
      ],
    );
  }
}
