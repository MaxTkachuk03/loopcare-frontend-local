import 'dart:async';

import 'package:flutter/material.dart';

import '../painters/river_streams_five_painter.dart';
import '../painters/river_streams_four_painter.dart';
import '../painters/river_streams_one_painter.dart';
import '../painters/river_streams_start_painter.dart';
import '../painters/river_streams_three_painter.dart';
import '../painters/river_streams_two_painter.dart';

const Duration _waveDuration = Duration(milliseconds: 1500);
const Duration _updatePositionDuration = Duration(seconds: 60);
const Duration _completeDuration = Duration(milliseconds: 50);

const double _notCompletedGradientPosition = 0.9;
const double _completedGradientPosition = 1.0;
const double _spawnedGradientPosition = 0.0;
const double _startGradientPosition = -0.12;

const double _completeBeginningPageStep = 1/30;
const double _defaultStep = 1/100;

class AnimatedRiverStreams extends StatefulWidget {
  const AnimatedRiverStreams({
    super.key,
    required this.page,
    required this.totalDays,
    required this.isCompleted,
    required this.completedDate,
  });

  final int page;
  final DateTime? completedDate;
  final int totalDays;
  final bool isCompleted;

  @override
  State<AnimatedRiverStreams> createState() => AnimatedRiverStreamsState();
}

class AnimatedRiverStreamsState extends State<AnimatedRiverStreams> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _startAnimation;
  late Animation<double> _endAnimation;

  late bool _fillColor;
  late bool _enableGradient;
  double _position = _startGradientPosition;
  Timer? _timer;

  bool get isBeginning => widget.page == 0;

  @override
  void initState() {
    super.initState();
    _fillColor = widget.isCompleted;
    _enableGradient = widget.completedDate != null || isBeginning;
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
          gradientPositionStart: _position + _startAnimation.value,
          gradientPositionEnd: _position + _endAnimation.value,
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
    } else if (isBeginning) {
      _position = _spawnedGradientPosition;
    } else if (widget.completedDate == null) {
      _position = _startGradientPosition;
    } else if (widget.completedDate!.isBefore(now)) {
      _position = _notCompletedGradientPosition;
    } else {
      _position = _definePosition(now);
    }

    setState(() {});
  }

  double _definePosition(DateTime dateTime) {
    final fullDuration = Duration(days: widget.totalDays);
    final leftDuration = widget.completedDate!.difference(dateTime);

    return _notCompletedGradientPosition * (1- leftDuration.inSeconds / fullDuration.inSeconds);
  }

  void _startTimer() {
    if ((widget.completedDate?.isAfter(DateTime.now()) ?? false) && !widget.isCompleted) {
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

    _startAnimation = Tween<double>(begin: -0.001, end: 0.003).animate(_controller);
    _endAnimation = Tween<double>(begin: 0.096, end: 0.11).animate(_controller);
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }

      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      }

      if (_position >= 1) {
        _fillColor = true;
        _stopAnimation();
      }
    });

    if (!widget.isCompleted && widget.completedDate != null) {
      _controller.forward();
    }
  }

  void _forceCompleteModule() {
    _timer?.cancel();
    final step = isBeginning ? _completeBeginningPageStep : _defaultStep;
    _timer = Timer.periodic(_completeDuration, (_) => _position += step);
  }

  void _spawnGradient() {
    _enableGradient = true;
    _controller.forward();

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
  }
}

class _RiverStreamsPainter extends StatelessWidget {
  const _RiverStreamsPainter({
    super.key,
    required this.enableGradient,
    required this.fillColor,
    required this.gradientPositionStart,
    required this.gradientPositionEnd,
    required this.index,
  });

  final bool enableGradient;
  final bool fillColor;
  final double gradientPositionStart;
  final double gradientPositionEnd;
  final int index;

  int _getIndex(int i) => i <= 5 ? i : _getIndex(i - 5);

  @override
  Widget build(BuildContext context) {
    final i = _getIndex(index);

    return switch (i) {
      1 => CustomPaint(
        painter: RiverStreamsOnePainter(
          gradientPositionStart: gradientPositionStart,
          gradientPositionEnd: gradientPositionEnd,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
      2 => CustomPaint(
        painter: RiverStreamsTwoPainter(
          gradientPositionStart: gradientPositionStart,
          gradientPositionEnd: gradientPositionEnd,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
      3 => CustomPaint(
        painter: RiverStreamsThreePainter(
          gradientPositionStart: gradientPositionStart,
          gradientPositionEnd: gradientPositionEnd,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
      4 => CustomPaint(
        painter: RiverStreamsFourPainter(
          gradientPositionStart: gradientPositionStart,
          gradientPositionEnd: gradientPositionEnd,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
      5 => CustomPaint(
        painter: RiverStreamsFivePainter(
          gradientPositionStart: gradientPositionStart,
          gradientPositionEnd: gradientPositionEnd,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
      _ => CustomPaint(
        painter: RiverStreamsStartPainter(
          gradientPositionStart: gradientPositionStart,
          gradientPositionEnd: gradientPositionEnd,
          enableGradient: enableGradient,
          fillColor: fillColor,
        ),
      ),
    };
  }
}
