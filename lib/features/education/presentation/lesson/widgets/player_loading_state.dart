import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:shimmer/shimmer.dart';

class PlayerLoadingState extends StatelessWidget {
  const PlayerLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.greyLight,
      highlightColor: AppColors.greyRegular,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Slider(value: 0, onChanged: (double value) {})),
              CustomText.w400("00:00", style: context.textTheme.bodyMedium),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 50),
              CustomIconButton(icon: Icon(Icons.play_arrow, size: 35)),
              CustomIconButton(icon: Icon(Icons.volume_up, size: 35)),
            ],
          ),
        ],
      ),
    );
  }
}
