import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/subscription/presentation/controller/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/domain/purchasable_product.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_plan_item.dart';

class SubscriptionPlanList extends StatelessWidget {
  final SubscriptionController controller;

  const SubscriptionPlanList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PurchasableProduct?>(
      valueListenable: controller.selectedPlan,
      builder: (context, selectedPlan, _) {
        final products = controller.products;
        return Column(
          children: [
            ...products.map(
              (product) => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: MultiplePlanItem(
                  title: product.title,
                  description: product.description,
                  showBadge: product.showBadge,
                  priceWithCurrency: product.priceWithCurrency,
                  onTap: () => controller.setPlans(product),
                  selected: _isPlanSelected(products),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _isPlanSelected(List<PurchasableProduct> products) {
    return controller.selectedPlan.value?.details.id == products.first.details.id &&
        controller.selectedPlan.value?.details.price == products.first.details.price;
  }
}
