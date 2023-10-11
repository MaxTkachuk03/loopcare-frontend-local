import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_status_widget.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late SubscriptionController controller;

  @override
  void initState() {
    super.initState();
    controller = SubscriptionController(bloc: context.read<SubscriptionBloc>());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.getPlans();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40.0),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: SizedBox(
                    width: 283,
                    height: 220,
                    child: Image(
                      width: double.infinity,
                      image: AppImages.physicalActivitiesIntro,
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.multiply,
                    ),
                  ),
                ),
              ),
            ),
            BlocConsumer<SubscriptionBloc, SubscriptionState>(
              listenWhen: (prev, cur) =>
                  cur is ErrorSubscriptionState || cur is SuccessSubscriptionPlans || cur is PurchasedSubscriptionState,
              listener: (BuildContext context, SubscriptionState state) => state.maybeWhen(
                successInPlans: (data) => controller.setupPlans(data),
                purchasedSubscription: (data) => context.router.replaceNamed(AppRoutes.home),
                orElse: () => _errorListener,
              ),
              builder: (BuildContext context, SubscriptionState state) => state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                trial: (s) => SubscriptionStatusWidget.trial(
                  controller: controller,
                ),
                trialExpired: (_) => SubscriptionStatusWidget.trialExpired(
                  controller: controller,
                ),
                subscriptionEnded: (_) => SubscriptionStatusWidget.endedSubscription(
                  controller: controller,
                ),
                subscriptionCancelled: (_) => SubscriptionStatusWidget.cancelledSubscription(
                  controller: controller,
                ),
                subscriptionUnRenewed: (_) => SubscriptionStatusWidget.notRenewSubscription(
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _errorListener(BuildContext context, SubscriptionState state) {
    showAppSnackBar(
      context: context,
      text: 'Something went wrong, try again',
      background: AppColors.red,
      textColor: Colors.white,
    );
    context.router.pop();
  }
}
