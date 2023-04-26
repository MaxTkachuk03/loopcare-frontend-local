import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';

class BottomNavigation extends StatelessWidget {
  final void Function(int index) onItemPress;
  final List<BottomNavigationBarItem> items;
  final DashboardNavbarItems selectedItem;

  const BottomNavigation({
    Key? key,
    required this.onItemPress,
    required this.items,
    required this.selectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(-2, 4), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 85.0,
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.bgGreen,
            items: items,
            iconSize: 32,
            currentIndex: selectedItem.index,
            selectedItemColor: AppColors.darkGreen,
            unselectedItemColor: AppColors.greyLabel,
            selectedFontSize: 12.0,
            unselectedFontSize: 12.0,
            onTap: onItemPress,
          ),
        ),
      ),
    );
  }
}
