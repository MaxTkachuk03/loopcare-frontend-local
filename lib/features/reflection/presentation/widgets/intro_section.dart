import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 42.0, top: 70.0),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.blueLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: AppIcons.introReflection,
          ),
          const SizedBox(
            height: 60.0,
          ),
          Text(
            '16 June 2023',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text(
            '4 week reflection',
            style: TextStyle(
              fontSize: ThemeConstants.fontSize30,
              fontFamily: ThemeConstants.bitterFontFamily,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          const Text(
            'Another month in the program finished. Way to go! Take a look at what you have achieved.',
          ),
        ],
      ),
    );
  }
}
