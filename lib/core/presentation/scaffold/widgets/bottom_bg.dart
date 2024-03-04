import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';

class BottomBg extends StatelessWidget {
  final Color color;

  const BottomBg({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 300,
        child: FittedBox(
          fit: BoxFit.fill,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(color, BlendMode.modulate),
            child: AppImages.bottomFrame,
          ),
        ),
      ),
    );
  }
}
