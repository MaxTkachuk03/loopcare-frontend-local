import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/domain/education_card_type.dart';
import 'package:loopcare_frontend/features/education/domain/education_item.dart';

class EducationCard extends StatelessWidget {
  final EducationItem item;

  const EducationCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? icon;

    if (item.type == EducationCardType.blocked) {
      icon = const ImageIcon(
        AppIcons.iconLock,
        color: AppColors.darkGreen,
      );
    }

    if (item.type == EducationCardType.available) {
      icon = const Image(image: AppImages.play);
    }

    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 14.0, left: 20.0),
      decoration: BoxDecoration(
        color: item.type == EducationCardType.blocked
            ? AppColors.white.withOpacity(0.6)
            : AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  item.label.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: ThemeConstants.fontSize12,
                        fontWeight: item.type == EducationCardType.available
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: item.type == EducationCardType.available
                            ? AppColors.orangeDark
                            : AppColors.greyLabel,
                      ),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkGreen,
                      ),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Row(
                  children: [
                    if (icon != null) icon,
                    const SizedBox(
                      width: 8.0,
                    ),
                    AppIcons.clock,
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      item.duration,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Image(image: AppImages.educationCardImage)
        ],
      ),
    );
  }
}
