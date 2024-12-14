import 'package:flutter/material.dart';

class SubscriptionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 1.274803, size.height * 1.068438);
    path.cubicTo(size.width * 1.237131, size.height * 1.187787, size.width * 1.118862,
        size.height * 1.279671, size.width * 0.9652359, size.height * 1.308938);
    path.lineTo(size.width * 0.5368667, size.height * 1.373319);
    path.cubicTo(size.width * 0.3852692, size.height * 1.402201, size.width * 0.2222218,
        size.height * 1.365713, size.width * 0.1086700, size.height * 1.277496);
    path.lineTo(size.width * -0.2501508, size.height * 0.9987311);
    path.cubicTo(size.width * -0.3637026, size.height * 0.9105120, size.width * -0.4106692,
        size.height * 0.7838426, size.width * -0.3734923, size.height * 0.6660677);
    path.lineTo(size.width * -0.2829718, size.height * 0.3392151);
    path.cubicTo(size.width * -0.2452992, size.height * 0.2198645, size.width * -0.1270287,
        size.height * 0.1279819, size.width * 0.02659590, size.height * 0.09871434);
    path.lineTo(size.width * 0.4843462, size.height * 0.01150747);
    path.cubicTo(size.width * 0.6359462, size.height * -0.01737388, size.width * 0.7989923,
        size.height * 0.01911349, size.width * 0.9125436, size.height * 0.1073311);
    path.lineTo(size.width * 1.263713, size.height * 0.3801514);
    path.cubicTo(size.width * 1.377264, size.height * 0.4683685, size.width * 1.424231,
        size.height * 0.5950398, size.width * 1.387054, size.height * 0.7128147);
    path.lineTo(size.width * 1.274803, size.height * 1.068438);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
