import 'package:flutter/material.dart';

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width * 0.9998162, size.height);
    path.cubicTo(size.width * 0.9915588, size.height * 0.9916354, size.width * 0.9837721,
        size.height * 0.9829635, size.width * 0.9765000, size.height * 0.9740000);
    path.lineTo(size.width * 0.7273765, size.height * 0.6858385);
    path.cubicTo(size.width * 0.6398941, size.height * 0.5780156, size.width * 0.6398941,
        size.height * 0.4446891, size.width * 0.7273772, size.height * 0.3368641);
    path.lineTo(size.width * 0.9880441, size.height * 0.01558161);
    path.cubicTo(size.width * 0.9918897, size.height * 0.01084510, size.width * 0.9958750,
        size.height * 0.006189792, size.width, size.height * 0.001617807);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.9998162, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
