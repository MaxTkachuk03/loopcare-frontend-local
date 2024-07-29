import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons_data.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/navigation_bar_item/navigation_bar_items.dart';

class NavigationBarItemWidget extends StatelessWidget {
  const NavigationBarItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
  });

  final NavigationBarItems item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ? 1.0 : 0.5,
      child: Builder(
        builder: (context) {
          if (item.isProfile) {
            // todo change to avatar
            return const SizedBox.square(
              dimension: 24,
              child: FittedBox(
                fit: BoxFit.none,
                child: Icon(
                  AppIconsData.iProfile,
                  color: AppColors.blueLightest,
                  size: 36,
                ),
              ),
            );
          } else if (item.isPractice) {
            return AppIcons.navigationBarPractice;
          } else {
            return AppIcons.navigationBarRiver;
          }
        },
      ),
    );
  }
}

