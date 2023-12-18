import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/reflection/presentation/widgets/details_button.dart';

class NutritionSection extends StatelessWidget {
  const NutritionSection({super.key});

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
            'Nutrition',
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
            image: AppImages.reflectionNutrition,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            'Nice work!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'You logged very filling meals. This will help you fight excessive hunger and cravings!',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 10.0,
          ),
          DetailsButton(
            onPressed: () => _onPressed(context),
          )
        ],
      ),
    );
  }

  void _onPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.reflectionNutritionDetails);
  }
}
