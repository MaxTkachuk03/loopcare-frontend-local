import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/donain/purchasable_product.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/restore_subscription_link.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_button.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_plane_item.dart';

class FooterSubscription extends StatefulWidget {
  final SubscriptionController controller;

  const FooterSubscription({
    super.key,
    required this.controller,
  });

  @override
  State<FooterSubscription> createState() => _FooterSubscriptionState();
}

class _FooterSubscriptionState extends State<FooterSubscription> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PurchasableProduct?>(
        valueListenable: widget.controller.selectedPlan,
        builder: (context, selectedPlan, _) {
          return Column(
            children: [
              const SizedBox(height: 18.0),
              SubscriptionPlane.annual(
                monthlyPrice: widget.controller.annual.monthlyPrice.toString(),
                commonPrice: widget.controller.annual.commonPrice.toString(),
                currency: widget.controller.annual.currency,
                onTap: () => widget.controller.setPlans(widget.controller.annual),
                selected: widget.controller.selectedPlan.value?.isAnnual ?? false,
              ),
              const SizedBox(height: 18.0),
              SubscriptionPlane.monthly(
                onTap: () => widget.controller.setPlans(widget.controller.monthly),
                monthlyPrice: widget.controller.monthly.monthlyPrice.toString(),
                commonPrice: widget.controller.monthly.commonPrice.toString(),
                currency: widget.controller.monthly.currency,
                selected: !(widget.controller.selectedPlan.value?.isAnnual ?? true),
              ),
              const SizedBox(height: 18.0),
              RestoreSubscriptionLink(onTap: () => widget.controller.restorePurchase()),
              const SizedBox(height: 34.0),
              SubscribeButton(controller: widget.controller),
              const SizedBox(height: 30.0),
            ],
          );
        });
  }
}
