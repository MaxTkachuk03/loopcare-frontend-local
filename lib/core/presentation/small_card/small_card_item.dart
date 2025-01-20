import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SmallCardItem extends StatelessWidget {
  const SmallCardItem({
    super.key,
    required this.url,
    required this.text,
    required this.checking,
    this.onPressed,
    required this.isCompleted,
  });

  final String url;
  final String text;
  final bool checking;
  final bool isCompleted;

  final void Function()? onPressed;

  static const double iconSize = 120.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(12)),
          child: Image(
            image: url.isNotEmpty
                ? NetworkImage(url) as ImageProvider<Object>
                : AppImages.nutrition,
            width: iconSize,
            height: checking
                ? iconSize
                : !isCompleted
                    ? 150
                    : iconSize,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
        Flexible(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: CustomText.bitter600(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    style: context.textTheme.titleMedium?.copyWith(
                        color: checking ? AppColors.greyLight : null),
                  ),
                ),
                checking
                    ? _CustomStatus(
                        text: LocalizedTexts.locked.tr(),
                        image: AppIcons.reflectionLocked,
                        checking: checking,
                      )
                    : isCompleted
                        ? _CustomStatus(
                            text: LocalizedTexts.completed.tr(),
                            image: AppIcons.reflectionCheckMark,
                            checking: checking,
                          )
                        : CustomElevatedButton.petrolSmall(
                            label: LocalizedTexts.start.tr(),
                            onPressed: onPressed,
                          )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomStatus extends StatelessWidget {
  const _CustomStatus({
    required this.text,
    required this.image,
    required this.checking,
  });

  final String text;
  final ImageProvider<Object> image;
  final bool checking;

  static const double checkmarkSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: image,
          width: checkmarkSize,
          height: checkmarkSize,
        ),
        const SizedBox(width: 8.0),
        CustomText.w600(
          text,
          textAlign: TextAlign.left,
          style: context.textTheme.bodySmall
              ?.copyWith(color: checking ? AppColors.greyLight : null),
        ),
      ],
    );
  }
}
