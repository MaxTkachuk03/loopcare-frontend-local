import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class EducationAppBar extends StatelessWidget {
  final Key containerKey;

  const EducationAppBar({super.key, required this.containerKey});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        key: containerKey,
        color: AppColors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36),
        child: const Column(
          children: [
            Text(
              'Taking one step at a time will have a huge impact',
              style: TextStyle(
                fontFamily: ThemeConstants.bitterFontFamily,
                color: AppColors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            AspectRatio(
              aspectRatio: 1.5,
              child: Image(
                image: AppImages.educationVideoPreview,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
