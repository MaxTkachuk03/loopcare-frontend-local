import 'package:flutter/material.dart';

class BulletListItem extends StatelessWidget {
  final Widget text;
  final double bulletSize;

  const BulletListItem({Key? key, required this.text, required this.bulletSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "\u2022",
          style: TextStyle(
            fontSize: bulletSize,
          ),
        ), //bullet text
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: text, //text
        )
      ],
    );
  }
}
