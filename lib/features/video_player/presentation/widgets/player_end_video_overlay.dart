import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/countdown.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/program_difficulty_chip.dart';
import 'package:video_player/video_player.dart';

class PlayerEndVideoOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final Orientation orientation;
  final PhysicalProgramExercise exercise;
  final VoidCallback onVideoEnds;
  final CountDownController countDownController;
  final String programType;
  final bool isLastVideo;
  final String programDifficulty;
  final int programLength;

  const PlayerEndVideoOverlay({
    Key? key,
    required this.controller,
    required this.orientation,
    required this.exercise,
    required this.onVideoEnds,
    required this.countDownController,
    required this.programType,
    required this.programDifficulty,
    required this.programLength,
    required this.isLastVideo,
  }) : super(key: key);

  bool get _isPortraitOrientation {
    return orientation == Orientation.portrait;
  }

  void _onRepeatHandler() {
    controller.play();
  }

  void _onNextHandler() {
    onVideoEnds();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: controller.value.size.width,
      height: controller.value.size.height,
      color: Colors.black45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LocalizedTexts.exerciseCompleteMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: _isPortraitOrientation ? 16.0 : 32.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: ThemeConstants.bitterFontFamily,
                  ),
                ).tr(namedArgs: {"currentIndex": '${exercise.order}', "length": '$programLength'}),
                Text(
                  exercise.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: _isPortraitOrientation ? 16.0 : 32.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: ThemeConstants.bitterFontFamily,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      programType.toUpperCase(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: _isPortraitOrientation ? 10.0 : 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    AppIcons.clockWhite,
                    const SizedBox(width: 6.0),
                    Text(
                      formatDuration(exercise.duration),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: _isPortraitOrientation ? 10.0 : 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ProgramDifficultyChip(text: programDifficulty),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 20.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(100, _isPortraitOrientation ? 32.0 : 52.0),
                        side: const BorderSide(width: 1.0, color: AppColors.white),
                      ),
                      onPressed: _onRepeatHandler,
                      child: Text(
                        LocalizedTexts.repeat,
                        style: TextStyle(fontSize: _isPortraitOrientation ? 12 : 14, color: AppColors.white),
                      ).tr(),
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: _onNextHandler,
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(Size(100, _isPortraitOrientation ? 32.0 : 52.0)),
                        backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                      ),
                      child: Text(
                        LocalizedTexts.next,
                        style: TextStyle(fontSize: _isPortraitOrientation ? 12 : 14),
                      ).tr(),
                    ),
                  ],
                ),
                Opacity(
                  opacity: isLastVideo ? 0 : 1,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          LocalizedTexts.breakBetweenExercises.tr().toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: _isPortraitOrientation ? 10.0 : 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      CountDown(
                        controller: countDownController,
                        duration: exercise.delayBeforeNext,
                        onComplete: onVideoEnds,
                        isPortraiteOrientation: _isPortraitOrientation,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
