import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/donain/purchasable_product.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/restore_subscription_link.dart';
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
              Column(
                  children: widget.controller.products
                      .map(
                        (product) => Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: SubscriptionPlane.general(
                            title: product.details?.title ?? '',
                            regularPrice: '${product.regularPrice}',
                            currency: product.currency,
                            onTap: () => widget.controller.setPlans(product),
                            selected: widget.controller.selectedPlan.value?.details?.id == product.details?.id &&
                                widget.controller.selectedPlan.value?.details?.price == product.details?.price,
                          ),
                        ),
                      )
                      .toList()),
              const SizedBox(height: 16.0),
              RestoreSubscriptionLink(onTap: () => widget.controller.restorePurchase()),
            ],
          );
        });
  }
}
