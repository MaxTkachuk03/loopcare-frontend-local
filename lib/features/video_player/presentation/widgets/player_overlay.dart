import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/player_controls.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/program_difficulty_chip.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/progress_bar.dart';
import 'package:video_player/video_player.dart';

class PlayerOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final Orientation orientation;
  final PhysicalProgramExercise exercise;
  final String programType;
  final String programDifficulty;
  final VoidCallback onSliderProgressChange;
  final VoidCallback? onPrevPressed;
  final VoidCallback onNextPressed;

  static const double _defaultVideoWidth = 1280.0;
  static const double _defaultVideoHeight = 720.0;

  const PlayerOverlay({
    Key? key,
    required this.controller,
    required this.orientation,
    required this.exercise,
    required this.programType,
    required this.programDifficulty,
    required this.onSliderProgressChange,
    this.onPrevPressed,
    required this.onNextPressed,
  }) : super(key: key);

  bool get _isPortraitOrientation {
    return orientation == Orientation.portrait;
  }

  void _onSkipExplanation() {
    if (controller.value.position.inSeconds >= exercise.explanationSkipTime) return;

    controller.seekTo(Duration(seconds: exercise.explanationSkipTime));
  }

  double get _videoWidth {
    final width = controller.value.size.width;

    return width != 0 ? width : _defaultVideoWidth;
  }

  double get _videoHeight {
    final height = controller.value.size.height;

    return height != 0 ? height : _defaultVideoHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _videoWidth,
      height: _videoHeight,
      color: Colors.black45,
      padding: EdgeInsets.symmetric(
          horizontal: _isPortraitOrientation ? 20.0 : 40.0, vertical: _isPortraitOrientation ? 10.0 : 30.0),
      child: Column(
        mainAxisAlignment: _isPortraitOrientation ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
        children: [
          if (!_isPortraitOrientation)
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (BuildContext context, VideoPlayerValue value, child) {
                final bool isVisible = value.position.inSeconds < exercise.explanationSkipTime;

                return Visibility(
                  visible: isVisible,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: _onSkipExplanation,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(const Size(186, 52.0)),
                        backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                      ),
                      child: const Text(LocalizedTexts.skipExplanation).tr(),
                    ),
                  ),
                );
              },
            ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    '${exercise.order}. ${exercise.name}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: _isPortraitOrientation ? 16.0 : 32.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: ThemeConstants.bitterFontFamily,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ProgramDifficultyChip(text: programDifficulty),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
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
                  Text(formatDuration(exercise.duration),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: _isPortraitOrientation ? 10.0 : 12.0,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
              if (!_isPortraitOrientation) const SizedBox(height: 24.0),
              ProgressBar(controller: controller, onSliderProgressChange: onSliderProgressChange),
              PlayerControls(
                controller: controller,
                onPrevPressed: onPrevPressed,
                onNextPressed: onNextPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
