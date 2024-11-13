import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/subscription/presentation/controller/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/restore_subscription_link.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_access_badge.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_button.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_gallery.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_plan_item.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SubscriptionSinglePlanPage extends StatelessWidget {
  final SubscriptionController controller;

  const SubscriptionSinglePlanPage({super.key, required this.controller});

  Color get textColor => AppColors.white;

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton(
      backgroundColor: AppColors.blueDarker,
      body: ScrollableContainer(
        child: MainContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText.bitter600(
                LocalizedTexts.subscriptionGenericTitle.tr(),
                textAlign: TextAlign.start,
                style: context.textTheme.displayLarge?.copyWith(color: textColor),
              ),
              const SizedBox(height: 16.0),
              SubscriptionGallery(
                images: controller.products.first.images,
              ),
              const SizedBox(height: 12.0),
              if (!controller.products.first.isPricedOffer)
                Center(
                  child: SubscriptionAccessBadge.limited(),
                ),
              SinglePlanItem(
                title: controller.products.first.title,
                titleColor: textColor,
                isPricedOffer: controller.products.first.isPricedOffer,
                badgeUrl: controller.products.first.subscriptionTranslation?.badge,
              ),
            ],
          ),
        ),
      ),
      button: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SubscribeButton(controller: controller),
          const SizedBox(height: 20.0),
          RestoreSubscriptionLink(
            onRestoreTap: () => controller.restorePurchase(),
            textColor: textColor,
          ),
        ],
      ),
    );
  }
}
