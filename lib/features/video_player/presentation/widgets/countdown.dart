import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CountDown extends StatelessWidget {
  final CountDownController controller;
  final int duration;
  final VoidCallback onComplete;

  const CountDown({
    Key? key,
    required this.controller,
    required this.duration,
    required this.onComplete,
  }) : super(key: key);

  _onTimeFormatterHandler(defaultFormatterFunction, duration) {
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
      width: 60,
      height: 60,
      ringColor: AppColors.d9d9d9,
      ringGradient: null,
      fillColor: AppColors.blueMid,
      fillGradient: null,
      backgroundColor: Colors.transparent,
      backgroundGradient: null,
      strokeWidth: 7.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 16.0,
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
