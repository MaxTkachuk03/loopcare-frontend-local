import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController tabController;
  final VoidCallback? onTap;
  final Color color;
  final Color borderColor;
  final Color? selectedLabelColor;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.tabController,
    required this.color,
    required this.borderColor,
    this.selectedLabelColor = AppColors.blueDarker,
    this.onTap,
  });

  factory CustomTabBar.coral(
          {required List<Widget> tabs,
          required TabController tabController,
          VoidCallback? onTap}) =>
      CustomTabBar(
        tabs: tabs,
        tabController: tabController,
        onTap: onTap,
        color: AppColors.coralOffRegular,
        borderColor: AppColors.coralRegular,
      );

  factory CustomTabBar.orange(
          {required List<Widget> tabs,
          required TabController tabController,
          VoidCallback? onTap}) =>
      CustomTabBar(
        tabs: tabs,
        tabController: tabController,
        onTap: onTap,
        color: AppColors.orangeOffRegular,
        borderColor: AppColors.orangeRegular,
      );

  factory CustomTabBar.yellow(
          {required List<Widget> tabs,
          required TabController tabController,
          VoidCallback? onTap}) =>
      CustomTabBar(
        tabs: tabs,
        tabController: tabController,
        onTap: onTap,
        color: AppColors.yellowOffRegular,
        borderColor: AppColors.yellowRegular,
      );

  factory CustomTabBar.green(
          {required List<Widget> tabs,
          required TabController tabController,
          VoidCallback? onTap}) =>
      CustomTabBar(
        tabs: tabs,
        tabController: tabController,
        onTap: onTap,
        color: AppColors.greenOffRegular,
        borderColor: AppColors.greenRegular,
      );

  factory CustomTabBar.petrol(
          {required List<Widget> tabs,
          required TabController tabController,
          VoidCallback? onTap}) =>
      CustomTabBar(
        tabs: tabs,
        tabController: tabController,
        onTap: onTap,
        color: AppColors.petrolOffRegular,
        borderColor: AppColors.petrolRegular,
        selectedLabelColor: AppColors.white,
      );

  factory CustomTabBar.blue(
          {required List<Widget> tabs,
          required TabController tabController,
          VoidCallback? onTap}) =>
      CustomTabBar(
        tabs: tabs,
        tabController: tabController,
        onTap: onTap,
        color: AppColors.blueOffRegular,
        borderColor: AppColors.blueRegular,
        selectedLabelColor: AppColors.white,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 2, color: borderColor, style: BorderStyle.solid),
      ),
      child: TabBar(
        onTap: (_) => onTap?.call(),
        controller: tabController,
        tabs: tabs,
        labelStyle: TabBarTheme.of(context).labelStyle?.copyWith(color: selectedLabelColor),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: AppColors.transparent,
        splashBorderRadius: BorderRadius.circular(50),
        indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: color),
      ),
    );
  }
}
