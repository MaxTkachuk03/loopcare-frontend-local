import 'package:flutter/material.dart';

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.cubicTo(size.width, size.height * 0.1, size.width, size.height / 5, size.width * 0.97,
        size.height * 0.29);
    path.cubicTo(size.width * 0.97, size.height * 0.29, size.width * 0.84, size.height * 0.74,
        size.width * 0.84, size.height * 0.74);
    path.cubicTo(size.width * 0.8, size.height * 0.9, size.width * 0.72, size.height,
        size.width * 0.63, size.height);
    path.cubicTo(size.width * 0.63, size.height, size.width * 0.36, size.height, size.width * 0.36,
        size.height);
    path.cubicTo(size.width * 0.28, size.height, size.width / 5, size.height * 0.9,
        size.width * 0.16, size.height * 0.74);
    path.cubicTo(size.width * 0.16, size.height * 0.74, size.width * 0.03, size.height * 0.29,
        size.width * 0.03, size.height * 0.29);
    path.cubicTo(size.width * 0.01, size.height / 5, 0, size.height * 0.1, 0, 0);
    path.cubicTo(0, 0, size.width, 0, size.width, 0);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
