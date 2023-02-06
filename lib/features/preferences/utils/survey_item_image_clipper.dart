import 'package:flutter/cupertino.dart';

class SurveyItemImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double offset = 25.0;
    path.lineTo(size.width - offset, 0.0);

    Offset firstControlPoint = Offset(size.width, size.height / 4);
    Offset firstPoint = Offset(size.width, size.height / 2 - 2.0);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    Offset secondControlPoint =
        Offset(size.width + 2.0, size.height - (size.height / 4));
    Offset secondPoint = Offset(size.width - offset, size.height);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
