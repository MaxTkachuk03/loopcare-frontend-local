import 'package:flutter/material.dart';

class SurveyImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 120);

    var firstControlPoint = Offset(size.width / 8, size.height);
    var firstPoint = Offset(size.width / 3, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstPoint.dx, firstPoint.dy);

    path.lineTo(size.width / 1.5, size.height);

    var secondControlPoint = Offset(size.width - (size.width / 8), size.height);
    var secondPoint = Offset(size.width, size.height - 120);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
