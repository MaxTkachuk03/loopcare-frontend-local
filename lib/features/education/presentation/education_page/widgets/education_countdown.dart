import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';

class EducationCountDown extends StatefulWidget {
  final int seconds;

  const EducationCountDown({super.key, required this.seconds});

  @override
  State<EducationCountDown> createState() => _EducationCountDownState();
}

class _EducationCountDownState extends State<EducationCountDown> {
  Timer? _timer;
  int _remainingTimeInSeconds = 0;
  int counterPeriodInSeconds = 1;

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
    return CustomText.w600(
      formatFullDuration(_remainingTimeInSeconds, withSeconds: true),
      style: context.textTheme.bodySmall,
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: counterPeriodInSeconds),
      (timer) {
        setState(
          () {
            final newRemainingTime = _remainingTimeInSeconds - counterPeriodInSeconds;

            if (newRemainingTime > 0) {
              _remainingTimeInSeconds -= counterPeriodInSeconds;
            } else {
              context.read<EducationProgramBloc>()
                ..add(const EducationProgramEvent.resetLessonWithCountdown())
                ..add(const EducationProgramEvent.getLessons())
                ..add(const EducationProgramEvent.setLessonWithCountdown());

              _timer?.cancel();
            }
          },
        );
      },
    );
  }
}
