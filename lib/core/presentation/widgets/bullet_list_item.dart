import 'package:flutter/material.dart';

class BulletListItem extends StatelessWidget {
  final Widget text;
  final double bulletSize;
  final String? bulletSign;
  final bool? centered;

  const BulletListItem({
    Key? key,
    required this.text,
    required this.bulletSize,
    this.bulletSign,
    this.centered,
  }) : super(key: key);

  String get _bulletSign => bulletSign == null ? "\u2022" : bulletSign!;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: centered ?? true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: centered ?? true ? 0 : 3.0),
          child: Text(_bulletSign, style: TextStyle(fontSize: bulletSize)),
        ),
        const SizedBox(width: 10.0),
        Expanded(child: text)
      ],
    );
  }
}
