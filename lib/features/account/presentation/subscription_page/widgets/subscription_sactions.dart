import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';

class SubscriptionSection extends StatelessWidget {
  const SubscriptionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        children: [
          const SectionTitle(title: LocalizedTexts.subscription),
          SectionItem(
            title: LocalizedTexts.manageSubscription,
            onPressHandler: () => context.router.pushNamed(AppRoutes.manageSubscription),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
