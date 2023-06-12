import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';

class EducationCountDown extends StatefulWidget {
  final int seconds;

  const EducationCountDown({Key? key, required this.seconds}) : super(key: key);

  @override
  State<EducationCountDown> createState() => _EducationCountDownState();
}

class _EducationCountDownState extends State<EducationCountDown> {
  Timer? _timer;
  int _remainingTimeInSeconds = 0;

  @override
  void initState() {
    _remainingTimeInSeconds = widget.seconds;

    _startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remainingTimeInSeconds ~/ 3600;
    final minutes = (((_remainingTimeInSeconds - hours * 3600)) / 60).ceil();
    final hoursOutput = hours != 0 ? '${hours}hrs' : '';
    final minutesOutput = minutes != 0 ? '${minutes}m' : '';

    if (hours <= 0 && minutes <= 0) return const SizedBox.shrink();

    return Text('$hoursOutput $minutesOutput');
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        final newRemainingTime = _remainingTimeInSeconds - 60;

        if (newRemainingTime > 0) {
          _remainingTimeInSeconds -= 60;
        } else {
          context.read<EducationProgramBloc>().add(const EducationProgramEvent.resetLessonWithCountdown());
          _timer?.cancel();
        }
      });
    });
  }
}
