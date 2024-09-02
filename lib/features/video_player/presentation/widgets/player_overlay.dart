import 'dart:async';

import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_utils.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/player_controls.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/program_difficulty_chip.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/progress_bar.dart';
import 'package:video_player/video_player.dart';

class PlayerOverlay extends StatefulWidget {
  final VideoPlayerController controller;
  final Orientation orientation;
  final PhysicalProgramExercise exercise;
  final String programType;
  final String programDifficulty;
  final VoidCallback? onPrevPressed;
  final VoidCallback onNextPressed;

  static const double _defaultVideoWidth = 1280.0;
  static const double _defaultVideoHeight = 720.0;

  const PlayerOverlay({
    super.key,
    required this.controller,
    required this.orientation,
    required this.exercise,
    required this.programType,
    required this.programDifficulty,
    required this.onNextPressed,
    this.onPrevPressed,
  });

  @override
  State<PlayerOverlay> createState() => _PlayerOverlayState();
}

class _PlayerOverlayState extends State<PlayerOverlay> {
  static const Duration _timerDuration = Duration(seconds: 5);
  static const Duration _animationDuration = Duration(milliseconds: 350);

  Timer? _timer;
  bool _showControls = false;

  void _setTimer() {
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

  void _onSlideChangeHandler() {
    if (_timer != null) _timer?.cancel();

    _setTimer();
  }

  void _showVideoControlsWithTimer() {
    if (_timer != null) _timer?.cancel();

    if (_showControls) {
      setState(() {
        _showControls = false;
      });
      return;
    }

    _setTimer();
  }

  void _onSkipExplanation() {
    if (widget.controller.value.position.inSeconds >= widget.exercise.explanationSkipTime) return;

    widget.controller.seekTo(Duration(seconds: widget.exercise.explanationSkipTime));
  }

  bool get _isPortraitOrientation {
    return widget.orientation == Orientation.portrait;
  }

  double get _videoWidth {
    final width = widget.controller.value.size.width;

    return width == 0 || width < PlayerOverlay._defaultVideoWidth ? PlayerOverlay._defaultVideoWidth : width;
  }

  double get _videoHeight {
    final height = widget.controller.value.size.height;

    return height != 0 || height < PlayerOverlay._defaultVideoHeight ? PlayerOverlay._defaultVideoHeight : height;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _showVideoControlsWithTimer,
          child: Container(
            width: _videoWidth,
            height: _videoHeight,
            color: Colors.transparent,
            child: null,
          ),
        ),
        GestureDetector(
          onTap: _showVideoControlsWithTimer,
          child: AnimatedOpacity(
            duration: _animationDuration,
            opacity: _showControls ? 1 : 0,
            child: Visibility(
              visible: _showControls,
              child: Container(
                width: _videoWidth,
                height: _videoHeight,
                color: Colors.black45,
                padding: EdgeInsets.symmetric(
                    horizontal: _isPortraitOrientation ? 20.0 : 40.0, vertical: _isPortraitOrientation ? 10.0 : 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            CustomText.bitter600(
                              '${widget.exercise.order}. ${widget.exercise.name}',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.white,
                                fontSize:
                                    _isPortraitOrientation ? ThemeConstants.fontSize16 : ThemeConstants.fontSize32,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            ProgramDifficultyChip(text: widget.programDifficulty),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          children: [
                            CustomText.w600(
                              widget.programType.toUpperCase(),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.white,
                                fontSize:
                                    _isPortraitOrientation ? ThemeConstants.fontSize10 : ThemeConstants.fontSize12,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            AppIcons.clockWhite,
                            const SizedBox(width: 6.0),
                            CustomText.w600(
                              formatSecondsToDurationString(widget.exercise.duration, alwaysShowSeconds: true),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.white,
                                fontSize:
                                    _isPortraitOrientation ? ThemeConstants.fontSize10 : ThemeConstants.fontSize12,
                              ),
                            ),
                          ],
                        ),
                        if (!_isPortraitOrientation) const SizedBox(height: 24.0),
                        ProgressBar(
                          controller: widget.controller,
                          onSliderProgressChange: _onSlideChangeHandler,
                        ),
                        PlayerControls(
                          controller: widget.controller,
                          onPrevPressed: widget.onPrevPressed,
                          onNextPressed: widget.onNextPressed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (!_isPortraitOrientation)
          Positioned(
            top: 30,
            right: 40,
            child: ValueListenableBuilder(
              valueListenable: widget.controller,
              builder: (BuildContext context, VideoPlayerValue value, child) {
                final bool isVisible = value.position.inSeconds < widget.exercise.explanationSkipTime;

                return Visibility(
                  visible: isVisible,
                  child: CustomElevatedButton.yellow(
                    label: LocalizedTexts.skipExplanation.tr(),
                    onPressed: _onSkipExplanation,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }
}
