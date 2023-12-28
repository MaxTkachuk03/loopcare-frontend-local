import 'package:flutter/material.dart';

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width * 0.9674330, size.height * -0.2068701);
    path.cubicTo(size.width * 1.010856, size.height * -0.04601023, size.width * 1.010856,
        size.height * 0.1528948, size.width * 0.9674330, size.height * 0.3137540);
    path.lineTo(size.width * 0.8380490, size.height * 0.7436494);
    path.cubicTo(size.width * 0.7952010, size.height * 0.9023908, size.width * 0.7165541, size.height,
        size.width * 0.6315077, size.height);
    path.lineTo(size.width * 0.3627629, size.height);
    path.cubicTo(size.width * 0.2777165, size.height, size.width * 0.1990693, size.height * 0.9023908,
        size.width * 0.1562198, size.height * 0.7436494);
    path.lineTo(size.width * 0.03256675, size.height * 0.3137540);
    path.cubicTo(size.width * -0.01085554, size.height * 0.1528943, size.width * -0.01085546,
        size.height * -0.04601069, size.width * 0.03256675, size.height * -0.2068707);
    path.lineTo(size.width * 0.1619508, size.height * -0.6861782);
    path.cubicTo(size.width * 0.2048003, size.height * -0.8449195, size.width * 0.2834459,
        size.height * -0.9425287, size.width * 0.3684923, size.height * -0.9425287);
    path.lineTo(size.width * 0.6315077, size.height * -0.9425287);
    path.cubicTo(size.width * 0.7165541, size.height * -0.9425287, size.width * 0.7952010,
        size.height * -0.8449195, size.width * 0.8380490, size.height * -0.6861782);
    path.lineTo(size.width * 0.9674330, size.height * -0.2068701);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
