import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_utils.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/video_player/infrastructure/video_page_controller.dart';
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
  final VideoPageController videoPageController;

  const PlayerEndVideoOverlay({
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
  });

  bool get _isPortraitOrientation {
    return orientation == Orientation.portrait;
  }

  void _onRepeatHandler() {
    videoPageController.setCountDownTimer(exercise.delayBeforeNext);
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText.bitter300(
                  LocalizedTexts.exerciseCompleteMessage
                      .tr(namedArgs: {"currentIndex": '${exercise.order}', "length": '$programLength'}),
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontSize: _isPortraitOrientation ? ThemeConstants.fontSize16 : ThemeConstants.fontSize32,
                  ),
                ),
                CustomText.bitter600(
                  exercise.name,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontSize: _isPortraitOrientation ? ThemeConstants.fontSize16 : ThemeConstants.fontSize32,
                  ),
                ),
                const SizedBox(height: 6.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.w600(
                      programType.toUpperCase(),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                        fontSize: _isPortraitOrientation ? ThemeConstants.fontSize10 : ThemeConstants.fontSize12,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    AppIcons.clockWhite,
                    const SizedBox(width: 6.0),
                    CustomText.w600(
                      formatSecondsToDurationString(exercise.duration, alwaysShowSeconds: true),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                        fontSize: _isPortraitOrientation ? ThemeConstants.fontSize10 : ThemeConstants.fontSize12,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ProgramDifficultyChip(text: programDifficulty),
                  ],
                ),
                const SizedBox(height: 6.0),
              ],
            ),
          ),
          if ((!isLastVideo))
            Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: _isPortraitOrientation ? 70 : 130,
                    child: CustomText.w600(
                      LocalizedTexts.breakBetweenExercises.tr().toUpperCase(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                        fontSize: _isPortraitOrientation ? 10.0 : 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //TODO return CustomOutlinedButton
                    _isPortraitOrientation
                        ? CustomElevatedButton.yellowSmall(
                            onPressed: _onRepeatHandler,
                            label: LocalizedTexts.repeat.tr(),
                          )
                        : CustomElevatedButton.yellow(
                            onPressed: _onRepeatHandler,
                            label: LocalizedTexts.repeat.tr(),
                          ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _isPortraitOrientation
                        ? CustomElevatedButton.yellowSmall(
                            onPressed: _onNextHandler,
                            label: LocalizedTexts.next.tr(),
                          )
                        : CustomElevatedButton.yellow(
                            onPressed: _onNextHandler,
                            label: LocalizedTexts.next.tr(),
                          ),
                    Container(
                      alignment: Alignment.center,
                      width: _isPortraitOrientation ? 70 : 130,
                      child: (!isLastVideo)
                          ? CountDown(
                              controller: countDownController,
                              duration: exercise.delayBeforeNext,
                              onComplete: onVideoEnds,
                              isPortraitOrientation: _isPortraitOrientation,
                              videoPageController: videoPageController,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}
