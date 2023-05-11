import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class EmptyMeal extends StatelessWidget {
  const EmptyMeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 58.0, horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(
                width: 100,
                height: 64,
                child: Image(
                  image: AppImages.emptyMeal,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                LocalizedTexts.logListEmptyMessage.translation,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.orangeDark),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
