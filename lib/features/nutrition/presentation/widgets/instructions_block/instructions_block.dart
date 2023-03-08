import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class InstructionsBlock extends StatelessWidget {
  const InstructionsBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: const [
                    Text('A'),
                    Align(
                      child: Image(
                        image: AppImages.calorieDensityFoodA,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  height: 8.0,
                  child: CalorieDensityScale(
                    density: 2.2,
                    separatorColor: AppColors.bgGreen,
                    layout: CalorieDensityScaleLayout.horizontal,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: const [
                    Text('B'),
                    Align(
                      child: Image(
                        image: AppImages.calorieDensityFoodB,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  height: 8.0,
                  child: CalorieDensityScale(
                    density: 1.4,
                    separatorColor: AppColors.bgGreen,
                    layout: CalorieDensityScaleLayout.horizontal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
