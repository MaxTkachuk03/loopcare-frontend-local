import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/clippers/subscription_clipper.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_button.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_footer.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_header_state.dart';

class _SubscriptionWrapperPage extends StatefulWidget {
  final Widget child;
  final AssetImage topCover;
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
        ),
        Positioned(
          top: 0.0,
          child: Image(image: widget.topCover),
        ),
        Positioned(
          top: 250,
          bottom: 0,
          child: ClipPath(
            clipper: SubscriptionClipper(),
            child: Container(
              padding: const EdgeInsets.only(top: 52),
              color: widget.bottomCover,
              width: MediaQuery.of(context).size.width,
              child: widget.child,
            ),
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

class _SubscriptionStatusWidget extends Column {
  _SubscriptionStatusWidget.trial({
    required SubscriptionController controller,
  }) : super(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SubscriptionTitle.trial(),
            _ScrollColumn(
              widgets: [
                const SubscriptionLabel.trial(),
                FooterSubscription(
                  controller: controller,
                ),
                SubscribeButton(controller: controller),
              ],
            ),
          ],
        );

  _SubscriptionStatusWidget.trialExpired({
    required SubscriptionController controller,
  }) : super(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SubscriptionTitle.trialExpired(),
            _ScrollColumn(
              widgets: [
                const SubscriptionLabel.trialExpired(),
                FooterSubscription(
                  controller: controller,
                ),
                SubscribeButton(controller: controller),
              ],
            ),
          ],
        );

  _SubscriptionStatusWidget.endedSubscription({
    required SubscriptionController controller,
  }) : super(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SubscriptionTitle.endedSubscription(),
            _ScrollColumn(
              widgets: [
                const SubscriptionLabel.endedSubscription(),
                FooterSubscription(
                  controller: controller,
                ),
                SubscribeButton(controller: controller),
              ],
            ),
          ],
        );

  _SubscriptionStatusWidget.cancelledSubscription({
    required SubscriptionController controller,
  }) : super(
          children: [
            const SubscriptionTitle.cancelledSubscription(),
            _ScrollColumn(
              widgets: [
                const SubscriptionLabel.cancelledSubscription(),
                FooterSubscription(
                  controller: controller,
                ),
                SubscribeButton(controller: controller),
              ],
            )
          ],
        );

  _SubscriptionStatusWidget.notRenewSubscription({
    Function()? onTap,
  }) : super(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SubscriptionTitle.notRenewSubscription(),
            const SubscriptionLabel.notRenewSubscription(),
            RenewButton(
              onTap: onTap,
            ),
          ],
        );

  _SubscriptionStatusWidget.serviceUnavailable()
      : super(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              child: SubscriptionLabel.serviceUnavailable(),
            ),
          ],
        );
}

class _ScrollColumn extends StatelessWidget {
  final List<Widget> widgets;

  const _ScrollColumn({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widgets),
          ),
        ],
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
          child: _SubscriptionStatusWidget.trial(controller: controller),
        );

  SubscriptionStateView.trialExpired({
    super.key,
    required super.controller,
    required super.bottomCover,
    required super.topCover,
  }) : super(
          child: _SubscriptionStatusWidget.trialExpired(controller: controller),
        );

  SubscriptionStateView.endedSubscription({
    super.key,
    required super.controller,
    required super.bottomCover,
    required super.topCover,
  }) : super(
          child: _SubscriptionStatusWidget.endedSubscription(controller: controller),
        );

  SubscriptionStateView.cancelledSubscription({
    super.key,
    required super.controller,
    required super.bottomCover,
    required super.topCover,
  }) : super(
          child: _SubscriptionStatusWidget.cancelledSubscription(controller: controller),
        );

  SubscriptionStateView.notRenewSubscription({
    super.key,
    Function()? onTap,
    required super.bottomCover,
    required super.topCover,
    required super.controller,
  }) : super(
          child: _SubscriptionStatusWidget.notRenewSubscription(onTap: onTap),
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
