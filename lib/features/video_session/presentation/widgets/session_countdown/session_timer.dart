import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/date_time_utils.dart';

class SessionTimer extends StatefulWidget {
  final int value;
  final void Function() onTimerEnds;

  const SessionTimer({super.key, required this.value, required this.onTimerEnds});

  @override
  State<SessionTimer> createState() => _SessionTimerState();
}

class _SessionTimerState extends State<SessionTimer> with WidgetsBindingObserver {
  static const _timerPeriod = Duration(seconds: 1);

  late Timer _sessionTimer;
  late int _timeBeforeStart;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    _timeBeforeStart = widget.value;

    _sessionTimer = Timer.periodic(_timerPeriod, timerCb);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      _sessionTimer.cancel();
    }

    if (state == AppLifecycleState.resumed) {
      _sessionTimer.cancel();
      _timeBeforeStart = context.read<TopicsBloc>().state.data.timeLeftToSessionStart.inSeconds;
      _sessionTimer = Timer.periodic(_timerPeriod, timerCb);
    }
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
    WidgetsBinding.instance.removeObserver(this);

    _sessionTimer.cancel();
    super.dispose();
  }
}
