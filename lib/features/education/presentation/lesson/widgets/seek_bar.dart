import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/duration_extensions.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    super.key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;

  _onChangeHandler(double value) {
    setState(() {
      _dragValue = value;
    });

    if (widget.onChanged != null) {
      widget.onChanged!(Duration(milliseconds: value.round()));
    }
  }

  _onChangeEndHandler(double value) {
    if (widget.onChangeEnd != null) {
      widget.onChangeEnd!(Duration(milliseconds: value.round()));
    }

    setState(() {
      _dragValue = null;
    });
  }

  get _value => min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
      widget.duration.inMilliseconds.toDouble());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Slider(
            thumbColor: AppColors.yellowRegular,
            min: 0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: _value,
            activeColor: AppColors.yellowRegular,
            inactiveColor: AppColors.greyLight,
            onChanged: _onChangeHandler,
            onChangeEnd: _onChangeEndHandler,
          ),
        ),
        CustomText.w400(
          (widget.duration - widget.position).toDurationString,
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

T? ambiguate<T>(T? value) => value;
