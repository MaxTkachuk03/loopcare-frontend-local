import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({Key? key}) : super(key: key);

  _onFoodHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.foodPreferences);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: LocalizedTexts.preferences),
        SectionItem(title: LocalizedTexts.food, onPressHandler: () => _onFoodHandler(context)),
        SectionItem(title: LocalizedTexts.physicalActivities, onPressHandler: () {}),
        SectionItem(title: LocalizedTexts.groupSessions, onPressHandler: () {}),
        SectionItem(title: LocalizedTexts.diabetes, onPressHandler: () {}),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
