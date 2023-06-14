import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class PhysicalExercise extends StatelessWidget {
  final bool isEditable;

  const PhysicalExercise({
    Key? key,
    required this.isEditable,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.selectExercise);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressHandler(context),
      child: Container(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 16.0,
          right: 16.0,
          left: 16.0,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  image: AppIcons.physicalExercise,
                ),
                const SizedBox(width: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalizedTexts.physicalExercise.translation,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontFamily: ThemeConstants.bitterFontFamily,
                          ),
                    ),
                    const SizedBox(height: 3.0),
                    // TODO get text from the server
                    AutoSizeText(
                      'Walking program - Squat',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                    ),
                    Text(
                      'Today',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF919B8C),
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const ImageIcon(
              AppIcons.arrow,
              color: AppColors.greyLabel,
            ),
          ],
        ),
      ),
    );
  }
}
