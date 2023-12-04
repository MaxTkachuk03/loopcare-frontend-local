import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

class CorrectCheckmark extends StatelessWidget {
  const CorrectCheckmark({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hexagon(
      width: 40,
      height: 40,
      borderRadius: 20,
      innerWidget: Container(
        color: AppColors.correctGreen,
        child: const Icon(
          Icons.done,
          color: AppColors.white,
          size: 12,
        ),
      ),
    );
  }
}
