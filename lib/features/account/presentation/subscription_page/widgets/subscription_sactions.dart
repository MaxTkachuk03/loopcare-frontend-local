import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SubscriptionSection extends StatelessWidget {
  const SubscriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        children: [
          SectionTitle(title: LocalizedTexts.subscriptionSubscription.tr()),
          SectionItem(
            title: LocalizedTexts.subscriptionManageSubscription.tr(),
            onPressHandler: () => context.router.pushNamed(AppRoutes.manageSubscription),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
