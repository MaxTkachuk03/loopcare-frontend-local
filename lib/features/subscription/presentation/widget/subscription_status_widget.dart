import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_button.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_footer.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_header_state.dart';


class SubscriptionStatusWidget extends Column {
  SubscriptionStatusWidget.trial({
    super.key,
    required SubscriptionController controller,
  }) : super(
          children: [
            SubscriptionHeader.trial(),
            FooterSubscription(
              controller: controller,
            ),
          ],
        );

  SubscriptionStatusWidget.trialExpired({
    super.key,
    required SubscriptionController controller,
  }) : super(
          children: [
            SubscriptionHeader.trialExpired(),
            FooterSubscription(
              controller: controller,
            ),
          ],
        );

  SubscriptionStatusWidget.endedSubscription({
    super.key,
    required SubscriptionController controller,
  }) : super(
          children: [
            SubscriptionHeader.endedSubscription(),
            FooterSubscription(
              controller: controller,
            ),
          ],
        );

  SubscriptionStatusWidget.cancelledSubscription({
    super.key,
    required SubscriptionController controller,
  }) : super(
          children: [
            SubscriptionHeader.cancelledSubscription(),
            FooterSubscription(
              controller: controller,
            ),
          ],
        );

  SubscriptionStatusWidget.notRenewSubscription({
    super.key,
    Function()? onTap,
  }) : super(
          children: [
            SubscriptionHeader.notRenewSubscription(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
              child: RenewButton(
                onTap: onTap,
              ),
            ),
          ],
        );
}
