import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';

class PhysicalActivitiesImageHeader extends StatelessWidget {
  const PhysicalActivitiesImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 283,
      height: 220,
      child: Image(
        width: double.infinity,
        image: AppImages.physicalActivitiesIntro,
        fit: BoxFit.cover,
        colorBlendMode: BlendMode.multiply,
      ),
    );
  }
}
