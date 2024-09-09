import 'package:flutter/material.dart';

class ActivityClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width * 1.0, size.height * 0.0);
    path.cubicTo(size.width * -0.7210000, size.height * -0.0386000, size.width * -0.0025200,
        size.height * 0.0009600, size.width * -0.0078600, size.height * 0.5514400);
    path.cubicTo(size.width * -0.0094000, size.height * 0.9892000, size.width * -0.7464600,
        size.height * 1.0280400, size.width * 0.9966200, size.height * 0.9946000);
    path.cubicTo(size.width * 0.8833800, size.height * 0.9007000, size.width * 0.6988800,
        size.height * 0.6994600, size.width * 0.7010000, size.height * 0.4982200);
    path.cubicTo(size.width * 0.6954600, size.height * 0.2986400, size.width * 0.8834000,
        size.height * 0.1000200, size.width * 1.0, size.height * 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
