import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/clippers/hexagon_clipper.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class UnderAppbar extends StatelessWidget {
  final Widget child;
  final Color? fillColor;

  const UnderAppbar({super.key, required this.child, this.fillColor});

  factory UnderAppbar.coral({required Widget child}) =>
      UnderAppbar(fillColor: AppColors.coralRegular, child: child);

  factory UnderAppbar.orange({required Widget child}) =>
      UnderAppbar(fillColor: AppColors.orangeRegular, child: child);

  factory UnderAppbar.yellow({required Widget child}) =>
      UnderAppbar(fillColor: AppColors.yellowRegular, child: child);

  factory UnderAppbar.green({required Widget child}) =>
      UnderAppbar(fillColor: AppColors.greenRegular, child: child);

  factory UnderAppbar.petrol({required Widget child}) =>
      UnderAppbar(fillColor: AppColors.petrolRegular, child: child);

  factory UnderAppbar.blue({required Widget child}) =>
      UnderAppbar(fillColor: AppColors.blueRegular, child: child);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HexagonClipper(),
      child: Container(
        width: double.infinity,
        height: 180,
        color: fillColor,
        child: child,
      ),
    );
  }
}
