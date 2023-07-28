import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({Key? key}) : super(key: key);

  void _onFoodHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.foodPreferences);
  }

  void _onGroupSessionsHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupPreferences);
  }

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        children: [
          const SectionTitle(title: LocalizedTexts.preferences),
          SectionItem(title: LocalizedTexts.food, onPressHandler: () => _onFoodHandler(context)),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0, color: AppColors.yellowLight),
          const SizedBox(height: 16.0),
          SectionItem(title: LocalizedTexts.physicalActivities, onPressHandler: () {}),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0, color: AppColors.yellowLight),
          const SizedBox(height: 16.0),
          SectionItem(
              title: LocalizedTexts.groupSessions, onPressHandler: () => _onGroupSessionsHandler(context)),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0, color: AppColors.yellowLight),
          const SizedBox(height: 16.0),
          SectionItem(title: LocalizedTexts.diabetes, onPressHandler: () {}),
        ],
      ),
    );
  }
}
