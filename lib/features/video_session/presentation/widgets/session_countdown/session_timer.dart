import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/utils/date_time_utils.dart';

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

    _handleAppState(state);
  }

  Future<void> _handleAppState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      _sessionTimer.cancel();
    }

    if (state == AppLifecycleState.resumed) {
      _sessionTimer.cancel();
      final Duration duration = await context.read<TopicsBloc>().state.data.timeLeftToSessionStart;

      _timeBeforeStart = duration.inSeconds;
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
      child: CustomText.bitter600(
        formatSecondsToDurationString(_timeBeforeStart),
        style: context.textTheme.displayLarge?.copyWith(color: AppColors.white),
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
