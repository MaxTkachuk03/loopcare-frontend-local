import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
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
            return Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 2.0,
                ),
                // todo add after upload avatar feature
                // image: DecorationImage(image: NetworkImage('https://variety.com/wp-content/uploads/2021/04/Avatar.jpg?w=800'))
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

