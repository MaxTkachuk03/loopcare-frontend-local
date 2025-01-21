import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/practice_lesson_list/practice_lesson_card_status_types.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';

import '../../../localization/service/Localized_texts.dart';
import '../buttons/custom_elevated_button.dart';
import '../icon_images/app_icons.dart';
import '../icon_images/app_images.dart';
import '../text/custom_text.dart';

class PracticeLessonCard extends StatelessWidget {
  final String url;
  final String text;
  final String status;
  final String buttonText;
  final void Function()? onPressed;

  const PracticeLessonCard({
    super.key,
    required this.url,
    required this.text,
    required this.status,
    required this.buttonText,
    this.onPressed,
  });

  static const double iconSize = 120.0;

  @override
  Widget build(BuildContext context) {
    final isLocked = status == PracticeLessonCardStatusTypes.locked.name;
    final isUnlocked = status == PracticeLessonCardStatusTypes.unlocked.name;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24.0),
        decoration: BoxDecoration(
          border: isLocked ? Border.all(color: AppColors.greyLighter) : null,
          borderRadius: isLocked ? BorderRadius.circular(10.0) : null,
          boxShadow: isLocked
              ? []
              : [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: AppColors.black.withOpacity(0.05)),
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 16,
                      color: AppColors.black.withOpacity(0.05))
                ],
        ),
        child: Card(
          shadowColor: isLocked ? Colors.transparent : Colors.black,
          margin: isLocked ? EdgeInsets.zero : const EdgeInsets.all(4.0),
          color: AppColors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                child: Image(
                  image:
                      url.isNotEmpty ? NetworkImage(url) as ImageProvider<Object> : AppImages.logo,
                  width: iconSize,
                  height: iconSize,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: CustomText.bitter600(
                        text,
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        style: context.textTheme.titleMedium
                            ?.copyWith(color: isLocked ? AppColors.greyLight : null),
                      ),
                    ),
                    isLocked
                        ? _CustomStatus(
                            text: LocalizedTexts.locked.tr(),
                            image: AppIcons.practiceLessonLocked,
                            isLocked: isLocked,
                          )
                        : isUnlocked
                            ? CustomElevatedButton.petrolSmall(
                                label: buttonText,
                                onPressed: onPressed,
                              )
                            : _CustomStatus(
                                text: LocalizedTexts.completed.tr(),
                                image: AppIcons.practiceLessonCompleted,
                                isLocked: isLocked,
                              )
                  ],
                ),
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomStatus extends StatelessWidget {
  const _CustomStatus({
    required this.text,
    required this.image,
    required this.isLocked,
  });

  final String text;
  final ImageProvider<Object> image;
  final bool isLocked;

  static const double iconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: image,
          width: iconSize,
          height: iconSize,
        ),
        const SizedBox(width: 8.0),
        CustomText.w600(
          text,
          textAlign: TextAlign.left,
          style:
              context.textTheme.bodySmall?.copyWith(color: isLocked ? AppColors.greyLight : null),
        ),
      ],
    );
  }
}
