import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_utils.dart';

class SessionTimer extends StatefulWidget {
  final int value;
  final void Function() onTimerEnds;

  const SessionTimer({super.key, required this.value, required this.onTimerEnds});

  @override
  State<SessionTimer> createState() => _SessionTimerState();
}

class _SessionTimerState extends State<SessionTimer> {
  static const _timerPeriod = Duration(seconds: 1);

  late Timer _sessionTimer;
  late int _timeBeforeStart;

  @override
  void initState() {
    _timeBeforeStart = widget.value;

    _sessionTimer = Timer.periodic(_timerPeriod, timerCb);

    super.initState();
  }

  void timerCb(_) {
    const reduceSecondsBy = 1;

    setState(() {
      final seconds = _timeBeforeStart - reduceSecondsBy;

      if (seconds < 0) {
        _sessionTimer.cancel();
        widget.onTimerEnds();
      } else {
        _timeBeforeStart = seconds;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        formatSecondsToDurationString(_timeBeforeStart),
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 28,
          fontFamily: 'Bitter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sessionTimer.cancel();

    super.dispose();
  }
}
