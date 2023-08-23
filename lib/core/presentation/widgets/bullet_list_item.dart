import 'package:flutter/material.dart';

class BulletListItem extends StatelessWidget {
  final Widget text;
  final double bulletSize;
  final String? bulletSign;

  const BulletListItem({Key? key, required this.text, required this.bulletSize, this.bulletSign})
      : super(key: key);

  String get _bulletSign => bulletSign == null ? "\u2022" : bulletSign!;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _bulletSign,
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
