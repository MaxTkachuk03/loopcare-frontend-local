import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
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

@RoutePage()
class SubscriptionPageV2 extends StatefulWidget {
  const SubscriptionPageV2({super.key});

  @override
  State<SubscriptionPageV2> createState() => _SubscriptionPageV2State();
}

class _SubscriptionPageV2State extends State<SubscriptionPageV2> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    context
        .read<SubscriptionV2Bloc>()
        .add(const SubscriptionV2Event.getPlans());

    _controller = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // to the end
      Future.delayed(const Duration(milliseconds: 500), () {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  int selectedPlanIndex = 10000000000;

  static const EdgeInsetsGeometry padding =
      EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0);

  void _onCheckMethod(int index, bool isChecked) {
    setState(() {
      selectedPlanIndex = index;
    });

    context
        .read<SubscriptionV2Bloc>()
        .add(SubscriptionV2Event.onCheckedPlan(isChecked, index));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<SubscriptionV2Bloc, SubscriptionV2State>(
      builder: (context, state) {
        return CustomScaffold(
          color: AppColors.white,
          appBar: CustomAppBar.blue(
            leading: CustomFilledIconButton.leadingBlueLighter(),
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
                    CategoryLabel.subscription(
                      label: state.data.label,
                    ),
                    const SizedBox(height: 10.0),
                    CustomText.bitter600(
                      state.data.title,
                      style: context.textTheme.displayLarge
                          ?.copyWith(fontSize: 32),
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(height: 10.0),
                    CustomText.w400(
                      state.data.subText,
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    controller: _controller,
                    padding: padding,
                    itemCount: state.data.plans.length,
                    itemBuilder: (context, index) {
                      final isChecked = selectedPlanIndex == index;
                      final status = state.data.plans[index].status;
                      final isLimited = state.data.plans[index].isLimited;

                      return SubscriptionPageV2Item(
                        price: state.data.plans[index].price,
                        title: state.data.plans[index].title,
                        status: status,
                        width: width,
                        isLimited: isLimited,
                        index: index,
                        isChecked: isChecked,
                        onPressed: () => _onCheckMethod(index, isChecked),
                        savings: state.data.plans[index].savings,
                        contentLength: state.data.plans[index].content.length,
                        content: state.data.plans[index].content,
                      );
                    }),
              ),
              Padding(
                padding: padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton.blueFullWidth(
                      onPressed: () {},
                      label: LocalizedTexts.subscriptionSubscribe.tr(),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: RestoreSubscriptionLink(
                        onRestoreTap: () {},
                        textColor: AppColors.greyLabel,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
