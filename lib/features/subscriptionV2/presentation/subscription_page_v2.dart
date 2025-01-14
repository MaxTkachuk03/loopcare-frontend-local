import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/restore_subscription_link.dart';
import 'package:loopcare_frontend/features/subscriptionV2/application/subscription_v2_bloc.dart';
import 'package:loopcare_frontend/features/subscriptionV2/presentation/subscription_page_v2_item.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import '../../../core/presentation/routes/app_router.gr.dart';
import '../../authentication/application/authentication_bloc.dart';
import '../../river/application/river_bloc.dart';
import '../../subscription/application/subscription_bloc.dart';
import '../../subscription/infrastructure/subscription_service.dart';

@RoutePage()
class SubscriptionPageV2 extends StatefulWidget {
  const SubscriptionPageV2({super.key});

  @override
  State<SubscriptionPageV2> createState() => _SubscriptionPageV2State();
}

class _SubscriptionPageV2State extends State<SubscriptionPageV2> {
  late final ScrollController _controller;
  late List<ProductDetails> subscriptionPlans = [];
  final Map<String, double> productIdToPriceMap = {};
  final appSubscriptionService = AppSubscriptionService();

  @override
  void initState() {
    super.initState();
    context.read<SubscriptionV2Bloc>().add(const SubscriptionV2Event.getPlans());
    _controller = ScrollController();

    _fetchSubscriptionPlans();

    appSubscriptionService.storeSubscription.listen((purchaseDetailsList) {
      _handlePurchaseUpdates(purchaseDetailsList);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        appSubscriptionService.completePurchase(purchaseDetails);
        _onPurchaseSuccess(purchaseDetails);
      }
    }
  }

  void _onPurchaseSuccess(PurchaseDetails purchaseDetails) {
    _navigateToHome();
  }

  int selectedPlanIndex = 3;

  static const EdgeInsetsGeometry padding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0);

  void _onCheckMethod(int index, bool isChecked) {
    setState(() {
      selectedPlanIndex = isChecked ? -1 : index;
    });

    context.read<SubscriptionV2Bloc>().add(SubscriptionV2Event.onCheckedPlan(isChecked, index));
  }

  Future<void> _fetchSubscriptionPlans() async {
    final Set<String> planIds = {
      'monthly',
      'quarterly',
      'annual',
      'NY_2025_15',
      'ny_2025_15',
    };

    final fetchedPlans = await appSubscriptionService.getSubscriptionPlans(planIds);
    setState(() {
      subscriptionPlans = fetchedPlans;
      for (var plan in fetchedPlans) {
        final double? price = _cleanAndParsePrice(plan.price);
        if (price != null) {
          productIdToPriceMap[plan.id] = price;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: _logoutListener,
      child: BlocBuilder<SubscriptionV2Bloc, SubscriptionV2State>(
        builder: (context, state) {
          return CustomScaffold(
            color: AppColors.white,
            appBar: CustomAppBar.blue(
              leading: const SizedBox.shrink(),
              actions: [_LogoutWidget()],
              title: LocalizedTexts.subscriptionSubscription.tr(),
            ),
            body: Column(
              children: [
                Padding(
                  padding: padding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryLabel.subscription(label: LocalizedTexts.subscriptionProgram.tr()),
                      const SizedBox(height: 10.0),
                      CustomText.bitter600(
                        LocalizedTexts.subscriptionGenericTitle.tr(),
                        style: context.textTheme.displayLarge?.copyWith(fontSize: 32),
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(height: 10.0),
                      CustomText.w400(LocalizedTexts.subscriptionDescriptionLabel.tr(),
                          style: context.textTheme.bodySmall),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    padding: padding,
                    itemCount: subscriptionPlans.isEmpty
                        ? 0
                        : subscriptionPlans.where((plan) {
                            double? price = _cleanAndParsePrice(plan.price);
                            return price != null;
                          }).length,
                    itemBuilder: (context, index) {
                      final filteredPlans = subscriptionPlans.where((plan) {
                        double? price = _cleanAndParsePrice(plan.price);
                        return price != null;
                      }).toList();

                      if (filteredPlans.isEmpty) {
                        return Container();
                      }

                      final plansId = state.data.plans[index].productId;

                      String platformSpecificProductId = plansId;
                      if (Platform.isIOS && plansId == "ny_2025_15") {
                        platformSpecificProductId = plansId.toUpperCase();
                      }

                      final matchingPlan = filteredPlans.firstWhere(
                        (plan) => plan.id == platformSpecificProductId,
                      );

                      double price = _cleanAndParsePrice(matchingPlan.price) ?? 0.0;

                      if (matchingPlan.id == 'quarterly') {
                        price = price / 3;
                      } else if (['annual', 'NY_2025_15', 'ny_2025_15'].contains(matchingPlan.id)) {
                        price = price / 12;
                      }
                      final symbol = matchingPlan.currencySymbol.isNotEmpty
                          ? matchingPlan.currencySymbol[matchingPlan.currencySymbol.length - 1]
                          : '';

                      return SubscriptionPageV2Item(
                        price: price,
                        title: state.data.plans[index].title,
                        type: state.data.plans[index].type,
                        currency: symbol,
                        status: state.data.plans[index].status,
                        width: width,
                        isLimited: state.data.plans[index].isLimited,
                        index: index,
                        isChecked: selectedPlanIndex == index,
                        onPressed: () => _onCheckMethod(index, selectedPlanIndex == index),
                        savings: state.data.plans[index].savings,
                        contentLength: state.data.plans[index].content.length,
                        content: state.data.plans[index].content,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
                  child: CustomElevatedButton.blueFullWidth(
                    onPressed: () async {
                      if (selectedPlanIndex != 10000000000) {
                        final filteredPlans = subscriptionPlans
                            .where((plan) => _cleanAndParsePrice(plan.price) != null)
                            .toList();
                        filteredPlans.sort((a, b) => (_cleanAndParsePrice(a.price) ?? 0)
                            .compareTo(_cleanAndParsePrice(b.price) ?? 0));

                        if (filteredPlans.length >= 2) {
                          final temp = filteredPlans[filteredPlans.length - 1];
                          filteredPlans[filteredPlans.length - 1] =
                              filteredPlans[filteredPlans.length - 2];
                          filteredPlans[filteredPlans.length - 2] = temp;
                        }

                        var selectedPlan = filteredPlans[selectedPlanIndex];
                        appSubscriptionService.buyItemInStore(selectedPlan);
                      }
                    },
                    label: LocalizedTexts.subscriptionSubscribe.tr(),
                  ),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: RestoreSubscriptionLink(
                    onRestoreTap: () {
                      appSubscriptionService.restorePurchase();
                    },
                    textColor: AppColors.greyLabel,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToHome() {
    PageRouteInfo path = const HomeRoute();
    if (!context.read<RiverBloc>().state.data.isBeginningComplete) {
      path = const RiverOverviewRoute();
    }

    context.router.replaceAll([path]);
  }
}

bool isVendorPlatform(String? vendor) =>
    Platform.isIOS && vendor == 'ios' || Platform.isAndroid && vendor == 'android';

double? _cleanAndParsePrice(String priceString) {
  if (priceString.isEmpty) {
    return null;
  }

  String cleanedPrice = priceString.replaceAll(RegExp(r'[^0-9.,]'), '').replaceAll(',', '.');
  double? parsedPrice = double.tryParse(cleanedPrice);
  return parsedPrice?.ceilToDouble();
}

void _logoutListener(BuildContext context, AuthenticationState state) {
  state.mapOrNull(
    guest: (state) {
      context.router.replaceAll([const IntroRoute()]);
    },
  );
}

class _LogoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.blueLighter,
        child: IconButton(
            icon: const Icon(
              Icons.logout,
              color: AppColors.blueDarkest,
            ),
            onPressed: () {
              context.read<SubscriptionBloc>().add(const SubscriptionEvent.logout());
              context.read<AuthenticationBloc>().add(const AuthenticationEvent.logout());
            }),
      ),
    );
  }
}
