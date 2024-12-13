import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/restore_subscription_link.dart';
import 'package:loopcare_frontend/features/subscriptionV2/application/subscription_v2_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class SubscriptionPageV2 extends StatefulWidget {
  const SubscriptionPageV2({super.key});

  @override
  State<SubscriptionPageV2> createState() => _SubscriptionPageV2State();
}

class _SubscriptionPageV2State extends State<SubscriptionPageV2> {

  @override
  void initState() {
    super.initState();
    context.read<SubscriptionV2Bloc>().add(const SubscriptionV2Event.getPlans());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionV2Bloc, SubscriptionV2State>(
      builder: (context, state) {
        return CustomScaffold(
          color: AppColors.white,
          appBar: CustomAppBar.blue(
            leading: CustomFilledIconButton.leadingBlueLighter(),
            title: LocalizedTexts.subscriptionSubscription.tr(),
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryLabel.subscription(
                  label: state.data.label,
                ),
                const SizedBox(height: 5.0),
                CustomElevatedButton.blueFullWidth(
                  // isLoading: loading,
                  onPressed: () {},
                  label: LocalizedTexts.subscriptionSubscribe.tr(),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: RestoreSubscriptionLink(
                    onRestoreTap: () {},
                    textColor: AppColors.greyLabel,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
