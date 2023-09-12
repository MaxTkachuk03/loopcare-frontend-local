import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/oval_bottom_border_clipper.dart';
import 'package:loopcare_frontend/core/presentation/widgets/survey_image_clipper.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class PhysicalActivitiesImageHeader extends StatelessWidget {
  const PhysicalActivitiesImageHeader({Key? key}) : super(key: key);

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
