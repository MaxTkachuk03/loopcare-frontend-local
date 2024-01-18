import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CloseAction extends StatelessWidget {
  const CloseAction({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 22,
      backgroundColor: AppColors.greenLighter,
      child: CloseButton(color: AppColors.blueDarker),
    );
  }
}
