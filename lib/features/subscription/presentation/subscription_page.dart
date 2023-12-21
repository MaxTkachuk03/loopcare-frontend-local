import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
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
  Widget content = const SizedBox.shrink();

  @override
  void initState() {
    super.initState();
    controller = SubscriptionController(bloc: context.read<SubscriptionBloc>());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.getSubscriptionPlans();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.transparent(
          leading: const SizedBox.shrink(),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: AppColors.orange,
                size: 24,
              ),
              onPressed: () => context.read<SubscriptionBloc>().add(const SubscriptionEvent.logout()),
            ),
          ],
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16.0),
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
                        Expanded(
                          child: BlocConsumer<SubscriptionBloc, SubscriptionState>(
                            listenWhen: _listenerStates,
                            listener: (BuildContext context, SubscriptionState state) => state.maybeWhen(
                              successInPlans: (data) => controller.setupPlans(data),
                              subscriptionActive: (data) => context.router.replaceNamed(AppRoutes.home),
                              purchasedSubscription: (data) => context.router.replaceNamed(AppRoutes.home),
                              loading: (data) => controller.handleLoading(data.isLoading),
                              logout: (_) => context.router.replaceAll([const IntroRoute()]),
                              error: (_) => _errorListener(context, state),
                              orElse: () => null,
                            ),
                            builder: (BuildContext context, SubscriptionState state) => state.maybeWhen(
                              orElse: () => content,
                              trial: (s) => content = SubscriptionStatusWidget.trial(
                                controller: controller,
                              ),
                              trialExpired: (_) => content = SubscriptionStatusWidget.trialExpired(
                                controller: controller,
                              ),
                              subscriptionEnded: (_) => content = SubscriptionStatusWidget.endedSubscription(
                                controller: controller,
                              ),
                              subscriptionCancelled: (_) => content = SubscriptionStatusWidget.cancelledSubscription(
                                controller: controller,
                              ),
                              subscriptionUnRenewed: (_) => content = SubscriptionStatusWidget.notRenewSubscription(
                                onTap: () => context.router.replaceNamed(AppRoutes.home),
                              ),
                              serviceSubscriptionUnavailable: (_) =>
                                  content = SubscriptionStatusWidget.serviceUnavailable(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: ValueListenableBuilder<bool>(
                  valueListenable: controller.loading,
                  builder: (context, loading, _) {
                    return loading ? const Loader() : const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _listenerStates(prev, cur) =>
      cur is ErrorSubscriptionState ||
      cur is SuccessSubscriptionPlans ||
      cur is PurchasedSubscriptionState ||
      cur is SubscriptionActual ||
      cur is LoadingSubscriptionState ||
      cur is LogoutState;

  _errorListener(BuildContext context, SubscriptionState state) {
    final errorMessage = state.data.error?.error ?? LocalizedTexts.somethingWentWrong.tr();
    controller.resetState();
    context.showErrorBar(
      content: Text(errorMessage),
      position: FlashPosition.top,
    );
  }
}
