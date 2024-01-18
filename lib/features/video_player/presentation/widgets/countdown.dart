import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/video_player/infrastructure/video_page_controller.dart';

class CountDown extends StatelessWidget {
  final CountDownController controller;
  final int duration;
  final VoidCallback onComplete;
  final bool isPortraitOrientation;
  final VideoPageController videoPageController;

  const CountDown({
    super.key,
    required this.controller,
    required this.duration,
    required this.onComplete,
    required this.isPortraitOrientation,
    required this.videoPageController,
  });

  _onTimeFormatterHandler(defaultFormatterFunction, duration) {
    if (duration.inSeconds == 0) {
      return "0";
    } else {
      return '${Function.apply(defaultFormatterFunction, [duration])}s';
    }
  }

  int get initialDuration => duration - videoPageController.countDownTimer.value;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: duration,
      initialDuration: initialDuration,
      controller: controller,
      width: isPortraitOrientation ? 40 : 54,
      height: isPortraitOrientation ? 40 : 54,
      ringColor: AppColors.d9d9d9,
      ringGradient: null,
      fillColor: AppColors.petrolRegular,
      fillGradient: null,
      backgroundColor: Colors.transparent,
      backgroundGradient: null,
      strokeWidth: isPortraitOrientation ? 5.0 : 7.0,
      strokeCap: StrokeCap.round,
      textStyle: context.textTheme.bodyMedium?.copyWith(
        fontSize: isPortraitOrientation ? 12.0 : 16.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontFamily: ThemeConstants.bitterFontFamily,
      ),
      textFormat: CountdownTextFormat.SS,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: true,
      onComplete: onComplete,
      timeFormatterFunction: _onTimeFormatterHandler,
    );
  }
}
