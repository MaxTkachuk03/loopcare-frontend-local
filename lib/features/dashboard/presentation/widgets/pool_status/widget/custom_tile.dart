import 'package:flutter/material.dart';
import '../../../../../../core/presentation/themes/themes.dart';

class CustomTile extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final Widget image;
  final FontWeight? fontWeight;

  const CustomTile(
      {super.key,
      required this.text,
      required this.color,
      required this.fontSize,
      required this.image,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image,
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: ThemeConstants.bitterFontFamily,
                    fontSize: fontSize,
                    color: color,
                    fontWeight: fontWeight ?? FontWeight.normal),
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
