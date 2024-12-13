import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class VideoPageController {
  final CountDownController countDownController;
  final int defaultCountDownValue;

  VideoPageController({required this.countDownController, required this.defaultCountDownValue});

  ValueNotifier<int> countDownTimer = ValueNotifier(0);
  ValueNotifier<Orientation> orientation = ValueNotifier(Orientation.portrait);

  void setCountDownTimer(int val) => countDownTimer.value = val;

  void setOrientation(Orientation val) {
    if (val != orientation.value) {
      final timeLeft = countDownController.getTime();
      if (timeLeft == null || timeLeft.isEmpty) {
        setCountDownTimer(defaultCountDownValue);
      } else {
        setCountDownTimer(int.parse(timeLeft));
      }
    }
    orientation.value = val;
  }

  void dispose() {
    countDownTimer.dispose();
    orientation.dispose();
  }
}
