import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class RangeItem extends StatelessWidget {
  final double position;
  final String label;

  const RangeItem({super.key, required this.position, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Positioned(
            left: position,
            child: Column(
              children: [
                CustomText.w600(label, style: context.textTheme.bodyMedium),
                Container(width: 2, color: AppColors.blueRegular, height: 15),
              ],
            ),
          )
        ],
      ),
    );
  }
}
