import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class EducationAppBar extends StatelessWidget {
  final Key containerKey;

  const EducationAppBar({super.key, required this.containerKey});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        key: containerKey,
        color: AppColors.petrolRegular,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CustomText.bitter600(
              LocalizedTexts.educationTitle.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.displayLarge?.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 28.0),
            const Image(image: AppImages.educationPreview),
          ],
        ),
      ),
    );
  }
}
