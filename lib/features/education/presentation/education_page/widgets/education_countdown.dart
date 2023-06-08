import 'dart:async';
import 'package:flutter/material.dart';

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
    final minutes = ((_remainingTimeInSeconds - hours * 3600)) ~/ 60;
    final hoursOutput = hours != 0 ? '${hours}hrs' : '';
    final minutesOutput = minutes != 0 ? '${minutes}m' : '';

    return Text('$hoursOutput $minutesOutput');
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        if (_remainingTimeInSeconds > 0) {
          _remainingTimeInSeconds -= 60;
        } else {
          _timer?.cancel();
        }
      });
    });
  }
}
