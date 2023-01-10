import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

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
          Hexagon(
              width: 90,
              height: 90,
              borderRadius: 20.0,
              innerWidget: Container(
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
              )),
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
