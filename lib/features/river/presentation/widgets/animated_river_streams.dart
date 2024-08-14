import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_five_painter.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_four_painter.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_one_painter.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_start_painter.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_three_painter.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_streams_two_painter.dart';

const Duration _waveDuration = Duration(milliseconds: 3000);
const Duration _updatePositionDuration = Duration(milliseconds: 60000);
const Duration _completeDuration = Duration(milliseconds: 50);

const double _completedGradientPosition = 1.0;
const double _endGradientPosition = 0.83;
const double _spawnedGradientPosition = 0.0;
const double _startGradientPosition = -0.12;

const double _completeBeginningPageStep = 1/50;
const double _defaultStep = 1/100;

class AnimatedRiverStreams extends StatefulWidget {
  const AnimatedRiverStreams({
    super.key,
    required this.page,
    required this.totalDelay,
    required this.isCompleted,
    required this.completedDate,
    this.driving = true,
    this.enableGradient,
    this.onCompleted,
  });

  final int page;
  final DateTime? completedDate;
  final int totalDelay;
  final bool isCompleted;
  final bool driving;
  final bool? enableGradient;
  final void Function()? onCompleted;

  @override
  State<AnimatedRiverStreams> createState() => AnimatedRiverStreamsState();
}

class AnimatedRiverStreamsState extends State<AnimatedRiverStreams> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late bool _fillColor;
  late bool _enableGradient;
  double _position = _startGradientPosition;
  Timer? _timer;

  bool get isBeginning => widget.page == 0;

  @override
  void initState() {
    super.initState();
    _fillColor = widget.isCompleted;
    _enableGradient = widget.completedDate != null || isBeginning || (widget.enableGradient ?? false);
    _setupPosition();
    _setupAnimationControllers();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant AnimatedRiverStreams oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isCompleted != widget.isCompleted) {
      _forceCompleteModule();
    }

    if (oldWidget.completedDate == null && widget.completedDate != null) {
      _spawnGradient();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return _RiverStreamsPainter(
          key: const Key('river_streams_painter'),
          index: widget.page,
          gradientPosition: _position,
          time: _animation.value,
          enableGradient: _enableGradient,
          fillColor: _fillColor,
        );
      },
    );
  }

  void _setupPosition() {
    final now = DateTime.now();

    if (widget.isCompleted) {
      _position = _completedGradientPosition;
    } else if ((widget.completedDate == null && !widget.driving) || isBeginning) {
      _position = _spawnedGradientPosition;
    } else if (widget.completedDate == null) {
      _position = _startGradientPosition;
    } else if (widget.completedDate!.isBefore(now) && widget.driving) {
      _position = _completedGradientPosition;
    } else {
      _position = _definePosition(now);
    }

    setState(() {});
  }

  double _definePosition(DateTime dateTime) {
    final leftDuration = widget.completedDate!.difference(dateTime);
    final position =  1- leftDuration.inSeconds.safeDivide(widget.totalDelay);

    if (widget.driving) {
      return position;
    } else {
      return min(position, _endGradientPosition);
    }
  }

  void _startTimer() {
    if ((widget.completedDate?.isAfter(DateTime.now()) ?? false) &&
        !widget.isCompleted &&
        widget.driving) {
      _timer?.cancel();
      _timer = Timer.periodic(_updatePositionDuration, (_) => _position = _definePosition(DateTime.now()));
    }
  }

  void _setupAnimationControllers() {
    _controller = AnimationController(
      duration: _waveDuration,
      reverseDuration: _waveDuration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);

     _controller.addListener(() {
      if (_position >= 1) {
        _fillColor = true;
        _stopAnimation();
      }
    });

    if (!widget.isCompleted && _enableGradient) {
      _controller.repeat(reverse: true);
    }
  }

  void _forceCompleteModule() {
    if (!_controller.isAnimating) {
      _controller.forward();
    }

    _timer?.cancel();
    final step = isBeginning ? _completeBeginningPageStep : _defaultStep;
    _timer = Timer.periodic(_completeDuration, (_) => _position += step);
  }

  void _spawnGradient() {
    _enableGradient = true;
    _controller.repeat(reverse: true);

    _timer?.cancel();
    _timer = Timer.periodic(_completeDuration, (_) {
      if (_position >= 0) {
        _timer?.cancel();
        _startTimer();
      }
      _position += _defaultStep;
    });
  }

  void _stopAnimation() {
    _timer?.cancel();
    _controller.stop();
    widget.onCompleted?.call();
  }
}

class _RiverStreamsPainter extends StatelessWidget {
  const _RiverStreamsPainter({
    super.key,
    required this.enableGradient,
    required this.fillColor,
    required this.gradientPosition,
    required this.time,
    required this.index,
  });

  final bool enableGradient;
  final bool fillColor;
  final double gradientPosition;
  final double time;
  final int index;

  int _getIndex(int i) => i <= 5 ? i : _getIndex(i - 5);

  @override
  Widget build(BuildContext context) {
    final i = _getIndex(index);

    return switch (i) {
      1 => CustomPaint(
        painter: RiverStreamsOnePainter(
          gradientPosition: gradientPosition,
          time: time,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
      2 => CustomPaint(
        painter: RiverStreamsTwoPainter(
          gradientPosition: gradientPosition,
          time: time,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
      3 => CustomPaint(
        painter: RiverStreamsThreePainter(
          gradientPosition: gradientPosition,
          time: time,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
      4 => CustomPaint(
        painter: RiverStreamsFourPainter(
          gradientPosition: gradientPosition,
          time: time,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
      5 => CustomPaint(
        painter: RiverStreamsFivePainter(
          gradientPosition: gradientPosition,
          time: time,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
      _ => CustomPaint(
        painter: RiverStreamsStartPainter(
          gradientPosition: gradientPosition,
          time: time,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
    };
  }
}

extension _SafeDivideDouble on num {
  double  safeDivide(num other) => other == 0 ? 0 : this / other;
}