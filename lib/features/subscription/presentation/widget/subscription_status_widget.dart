import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_button.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_footer.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_header_state.dart';

class _SubscriptionWrapperPage extends StatefulWidget {
  final Widget child;
  final SvgPicture topCover;
  final Color bottomCover;
  final SubscriptionController controller;

  const _SubscriptionWrapperPage({
    super.key,
    required this.child,
    required this.topCover,
    required this.bottomCover,
    required this.controller,
  });

  @override
  State<_SubscriptionWrapperPage> createState() => _SubscriptionWrapperPageState();
}

class _SubscriptionWrapperPageState extends State<_SubscriptionWrapperPage> {
  final GlobalKey coverKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.zero,
            color: widget.bottomCover,
            child: widget.child,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: ValueListenableBuilder<bool>(
              valueListenable: widget.controller.loading,
              builder: (context, loading, _) {
                return loading ? const Loader() : const SizedBox.shrink();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SubscriptionStatusWidget extends _ScrollColumn {
  _SubscriptionStatusWidget.trial({
    required SubscriptionController controller,
    required Widget topCover,
  }) : super(widgets: [
          Column(
            children: [
              topCover,
              SubscriptionTitle.trial(),
              SubscriptionLabel.trial(),
              FooterSubscription(
                controller: controller,
              ),
            ],
          ),
          SubscribeButton(controller: controller),
        ]);

  _SubscriptionStatusWidget.trialExpired({
    required SubscriptionController controller,
    required Widget topCover,
  }) : super(widgets: [
          Column(
            children: [
              topCover,
              SubscriptionTitle.trialExpired(),
              SubscriptionLabel.trialExpired(),
              FooterSubscription(
                controller: controller,
              ),
            ],
          ),
          SubscribeButton(controller: controller),
        ]);

  _SubscriptionStatusWidget.endedSubscription({
    required SubscriptionController controller,
    required Widget topCover,
  }) : super(
          widgets: [
            Column(
              children: [
                topCover,
                SubscriptionTitle.endedSubscription(),
                SubscriptionLabel.endedSubscription(),
                FooterSubscription(
                  controller: controller,
                ),
              ],
            ),
            SubscribeButton(controller: controller),
          ],
        );

  _SubscriptionStatusWidget.cancelledSubscription({
    required SubscriptionController controller,
    required Widget topCover,
  }) : super(
          widgets: [
            Column(
              children: [
                topCover,
                SubscriptionTitle.cancelledSubscription(),
                SubscriptionLabel.cancelledSubscription(),
                FooterSubscription(
                  controller: controller,
                ),
              ],
            ),
            SubscribeButton(controller: controller),
          ],
        );

  _SubscriptionStatusWidget.notRenewSubscription({
    Function()? onTap,
    required Widget topCover,
  }) : super(widgets: [
          Column(
            children: [
              topCover,
              SubscriptionTitle.notRenewSubscription(),
              SubscriptionLabel.notRenewSubscription(),
            ],
          ),
          RenewButton(
            onTap: onTap,
          ),
        ]);

  _SubscriptionStatusWidget.serviceUnavailable()
      : super(
          widgets: [
            const SizedBox(height: 10.0),
            SubscriptionTitle.serviceUnavailable(),
            const SizedBox(height: 16.0),
          ],
        );
}

class _ScrollColumn extends StatelessWidget {
  final List<Widget> widgets;

  const _ScrollColumn({required this.widgets});

  @override
  Widget build(BuildContext context) {
    return ScrollableContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widgets,
      ),
    );
  }
}

class SubscriptionStateView extends _SubscriptionWrapperPage {
  SubscriptionStateView.trial({
    super.key,
    required super.controller,
    required super.bottomCover,
    required super.topCover,
  }) : super(
          child: _SubscriptionStatusWidget.trial(
            controller: controller,
            topCover: topCover,
          ),
        );

  SubscriptionStateView.trialExpired({
    super.key,
    required super.controller,
    required super.bottomCover,
    required super.topCover,
  }) : super(
          child: _SubscriptionStatusWidget.trialExpired(
            controller: controller,
            topCover: topCover,
          ),
        );

  SubscriptionStateView.endedSubscription({
    super.key,
    required super.controller,
    required super.bottomCover,
    required super.topCover,
  }) : super(
          child: _SubscriptionStatusWidget.endedSubscription(
            controller: controller,
            topCover: topCover,
          ),
        );

  SubscriptionStateView.cancelledSubscription({
    super.key,
    required super.controller,
    required super.bottomCover,
    required super.topCover,
  }) : super(
          child: _SubscriptionStatusWidget.cancelledSubscription(
            controller: controller,
            topCover: topCover,
          ),
        );

  SubscriptionStateView.notRenewSubscription({
    super.key,
    Function()? onTap,
    required super.bottomCover,
    required super.topCover,
    required super.controller,
  }) : super(
          child: _SubscriptionStatusWidget.notRenewSubscription(
            onTap: onTap,
            topCover: topCover,
          ),
        );

  SubscriptionStateView.serviceUnavailable({
    super.key,
    required super.bottomCover,
    required super.topCover,
    required super.controller,
  }) : super(
          child: _SubscriptionStatusWidget.serviceUnavailable(),
        );
}
