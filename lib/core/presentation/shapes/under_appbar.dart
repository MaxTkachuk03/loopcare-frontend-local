import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/clippers/hexagon_clipper.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const _defaultHeight = 180.0;

class UnderAppbar extends StatelessWidget {
  final Widget child;
  final Color? fillColor;
  final double? height;

  const UnderAppbar({super.key, required this.child, this.fillColor, this.height});

  factory UnderAppbar.coral({required Widget child, double? height}) =>
      UnderAppbar(fillColor: AppColors.coralRegular, height: height, child: child);

  factory UnderAppbar.orange({required Widget child}) =>
      UnderAppbar(fillColor: AppColors.orangeRegular, child: child);

  factory UnderAppbar.yellow({required Widget child}) =>
      UnderAppbar(fillColor: AppColors.yellowRegular, child: child);

  factory UnderAppbar.green({required Widget child}) =>
      UnderAppbar(fillColor: AppColors.greenRegular, child: child);

  factory UnderAppbar.petrol({required Widget child}) =>
      UnderAppbar(fillColor: AppColors.petrolRegular, child: child);

  factory UnderAppbar.blue({required Widget child, double? height}) =>
      UnderAppbar(fillColor: AppColors.blueRegular, height: height, child: child);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HexagonClipper(),
      child: Container(
        width: double.infinity,
        height: height ?? _defaultHeight,
        color: fillColor,
        child: child,
      ),
    );
  }
}
