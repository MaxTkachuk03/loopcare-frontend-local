import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';

class IntroItem extends StatelessWidget {
  final AssetImage image;
  final String text;
  final Color color;

  const IntroItem({
    Key? key,
    required this.image,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.70,
      child: Row(
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: ClipPolygon(
              sides: 6,
              borderRadius: 20.0,
              rotate: 90.0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      color.withOpacity(0.8),
                      BlendMode.multiply,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
              child: Text(
            text,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            softWrap: true,
          )),
        ],
      ),
    );
  }
}
