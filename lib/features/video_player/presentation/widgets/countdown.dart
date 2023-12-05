import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CountDown extends StatelessWidget {
  final CountDownController controller;
  final int duration;
  final VoidCallback onComplete;
  final bool isPortraitOrientation;
  final Function(Duration value) onDurationChange;

  const CountDown({
    super.key,
    required this.controller,
    required this.duration,
    required this.onComplete,
    required this.isPortraitOrientation,
    required this.onDurationChange,
  });

  _onTimeFormatterHandler(defaultFormatterFunction, duration) {
    onDurationChange(duration);
    if (duration.inSeconds == 0) {
      return "0";
    } else {
      return '${Function.apply(defaultFormatterFunction, [duration])}s';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: duration,
      initialDuration: 0,
      controller: controller,
      width: isPortraitOrientation ? 40 : 60,
      height: isPortraitOrientation ? 40 : 60,
      ringColor: AppColors.d9d9d9,
      ringGradient: null,
      fillColor: AppColors.blueMid,
      fillGradient: null,
      backgroundColor: Colors.transparent,
      backgroundGradient: null,
      strokeWidth: isPortraitOrientation ? 5.0 : 7.0,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
        fontSize: isPortraitOrientation ? 12.0 : 16.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
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
