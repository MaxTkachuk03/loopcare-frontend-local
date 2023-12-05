import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/survey_image_clipper.dart';

class PhysicalActivitiesImageHeader extends StatelessWidget {
  const PhysicalActivitiesImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: SurveyImageClipper(),
          child: Container(
            height: 120,
            width: double.infinity,
            color: AppColors.white,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Center(
            child: SizedBox(
              width: 283,
              height: 220,
              child: Image(
                width: double.infinity,
                image: AppImages.physicalActivitiesIntro,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.multiply,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
