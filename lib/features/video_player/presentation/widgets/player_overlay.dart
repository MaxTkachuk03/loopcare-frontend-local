import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/video_player/presentation/video_page.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/player_controls.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/program_difficulty_chip.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/progress_bar.dart';
import 'package:video_player/video_player.dart';

class PlayerOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final Orientation orientation;
  final Exercise exercise;
  final String programType;
  final String programDifficulty;
  final int programLenght;

  const PlayerOverlay({
    Key? key,
    required this.controller,
    required this.orientation,
    required this.exercise,
    required this.programType,
    required this.programDifficulty,
    required this.programLenght,
  }) : super(key: key);

  bool get _isPortraiteOrientation {
    return orientation == Orientation.portrait;
  }

  void _onSkipExplanation() {
    // TODO timestamp to seek to in the video
    final val = 0;
    controller.seekTo(Duration(microseconds: (val * 1000).toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: _isPortraiteOrientation ? 0.0 : 30.0),
      child: Column(
        mainAxisAlignment: _isPortraiteOrientation ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
        children: [
          if (!_isPortraiteOrientation)
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 186,
                child: ElevatedButton(
                  onPressed: _onSkipExplanation,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(186, 52.0)),
                    backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                  ),
                  child: const Text(LocalizedTexts.skipExplanation).tr(),
                ),
              ),
            ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    '${exercise.order}. ${exercise.name}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: _isPortraiteOrientation ? 16.0 : 32.0,
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
                      fontSize: _isPortraiteOrientation ? 10.0 : 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  AppIcons.clockWhite,
                  const SizedBox(width: 6.0),
                  Text(exercise.duration,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: _isPortraiteOrientation ? 10.0 : 12.0,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
              if (!_isPortraiteOrientation) const SizedBox(height: 24.0),
              ProgressBar(controller: controller),
              PlayerControls(controller: controller),
            ],
          ),
        ],
      ),
    );
  }
}
