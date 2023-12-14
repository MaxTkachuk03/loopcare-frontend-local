import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/sliver_app_bar_delegate.dart';

class EducationTabBar extends StatelessWidget {
  final TabController controller;
  final List<Widget> tabs;

  const EducationTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverAppBarDelegate(
        TabBar(
          controller: controller,
          tabs: tabs,
        ),
      ),
      pinned: true,
    );
  }
}
