import 'package:flutter/material.dart';

class ScaleGestureDetector extends StatefulWidget {
  const ScaleGestureDetector({
    super.key,
    required this.child,
    this.onTap,
    this.onZoomOut,
    this.onZoomIn,
  });

  final Widget child;
  final void Function()? onTap;
  final void Function()? onZoomOut;
  final void Function()? onZoomIn;

  @override
  State<ScaleGestureDetector> createState() => _ScaleGestureDetectorState();
}

class _ScaleGestureDetectorState extends State<ScaleGestureDetector> {
  double _scale = 1.0;

  void _onScaleUpdate(ScaleUpdateDetails details) => _scale = details.scale;

  void _onScaleEnd(ScaleEndDetails details) =>
      _scale > 1 ? widget.onZoomIn?.call() : widget.onZoomOut?.call();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onScaleUpdate: _onScaleUpdate,
      onScaleEnd: _onScaleEnd,
      child: widget.child,
    );
  }
}
