import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

class BackButtonHexagon extends StatelessWidget {
  final Color? background;

  const BackButtonHexagon({super.key, this.background});

  @override
  Widget build(BuildContext context) {
    return Hexagon(
      width: 54,
      height: 54,
      borderRadius: 16,
      innerWidget: Container(
        color: background ?? AppColors.white.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
            size: 18,
          ),
          onPressed: context.router.maybePop,
        ),
      ),
    );
  }
}
