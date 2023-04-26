import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/sliver_app_bar_delegate.dart';

class EducationTabBar extends StatelessWidget {
  const EducationTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverAppBarDelegate(
        TabBar(
          tabs: [
            Tab(text: LocalizedTexts.all.translation),
            Tab(text: LocalizedTexts.general.translation),
            Tab(text: LocalizedTexts.nutrition.translation),
            Tab(text: LocalizedTexts.mind.translation),
            Tab(text: LocalizedTexts.activity.translation),
          ],
        ),
      ),
      pinned: true,
    );
  }
}
