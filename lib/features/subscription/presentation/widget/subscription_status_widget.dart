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
            Expanded(
              child: FooterSubscription(
                controller: controller,
              ),
            ),
            SubscribeButton(controller: controller),
          ],
        );

  SubscriptionStatusWidget.trialExpired({
    super.key,
    required SubscriptionController controller,
  }) : super(
          children: [
            SubscriptionHeader.trialExpired(),
            Expanded(
              child: FooterSubscription(
                controller: controller,
              ),
            ),
            SubscribeButton(controller: controller),
          ],
        );

  SubscriptionStatusWidget.endedSubscription({
    super.key,
    required SubscriptionController controller,
  }) : super(
          children: [
            SubscriptionHeader.endedSubscription(),
            Expanded(
              child: FooterSubscription(
                controller: controller,
              ),
            ),
            SubscribeButton(controller: controller),
          ],
        );

  SubscriptionStatusWidget.cancelledSubscription({
    super.key,
    required SubscriptionController controller,
  }) : super(
          children: [
            SubscriptionHeader.cancelledSubscription(),
            Expanded(
              child: FooterSubscription(
                controller: controller,
              ),
            ),
            SubscribeButton(controller: controller),
          ],
        );

  SubscriptionStatusWidget.notRenewSubscription({
    super.key,
    Function()? onTap,
  }) : super(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: SubscriptionHeader.notRenewSubscription()),
            RenewButton(
              onTap: onTap,
            ),
          ],
        );
}
