import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/reflection/presentation/widgets/details_button.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Physical activities',
            style: TextStyle(
              fontSize: ThemeConstants.fontSize24,
              fontFamily: ThemeConstants.bitterFontFamily,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Image(
            width: double.infinity,
            image: AppImages.reflectionActivities,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Image(
            width: double.infinity,
            image: AppImages.reflectionActivitiesTable,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            'Keep going!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'Every small training session you do proves your determination and brings you one step closer to your new healthier you. Embrace the process and learn to enjoy it.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 10.0,
          ),
          const DetailsButton()
        ],
      ),
    );
  }
}
