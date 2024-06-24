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
  final Future<void> Function()? onZoomOut;
  final Future<void> Function()? onZoomIn;

  @override
  State<ScaleGestureDetector> createState() => _ScaleGestureDetectorState();
}

class _ScaleGestureDetectorState extends State<ScaleGestureDetector> {
  double _scale = 1.0;
  bool _handeled = false;

  void _onScaleUpdate(ScaleUpdateDetails details) => _scale = details.scale;

  void _onScaleEnd(ScaleEndDetails details) {
    if (!_handeled) {
      _handeled = true;
     (_scale > 1 ?  widget.onZoomIn : widget.onZoomOut)
         ?.call().whenComplete(() => _handeled = false);
    }
  }

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
