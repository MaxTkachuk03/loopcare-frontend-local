import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/reflection/presentation/widgets/details_button.dart';

class MindSection extends StatelessWidget {
  const MindSection({Key? key}) : super(key: key);

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
            'Mind',
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
            image: AppImages.reflectionMind,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            'A happy mind is a healthy mind',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'Great to see that you are doing so well.',
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
