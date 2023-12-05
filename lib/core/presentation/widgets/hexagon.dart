import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';

class Hexagon extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget innerWidget;

  const Hexagon({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.innerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipPolygon(
        sides: 6,
        borderRadius: borderRadius,
        rotate: 90.0,
        child: innerWidget,
      ),
    );
  }
}
