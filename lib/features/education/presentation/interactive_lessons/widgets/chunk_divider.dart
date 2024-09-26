import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ChunkDivider extends StatelessWidget {
  const ChunkDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 50),
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.blueRegular,
      ),
    );
  }
}
