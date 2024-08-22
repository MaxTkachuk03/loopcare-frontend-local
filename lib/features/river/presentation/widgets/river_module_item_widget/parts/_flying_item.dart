part of '../river_animation_module_item_widget.dart';

Future<void> _showTransitionItemAnimation({
  required BuildContext context,
  required Offset startPosition,
  required Offset endPosition,
  required Widget item,
  required void Function() onEnd,
}) {
  final GlobalKey itemKey = GlobalKey();
  final NavigatorState navigator = Navigator.of(context);

  return navigator.push(_FlyingItemRoute(
    onEnd: onEnd,
    startPosition: startPosition,
    endPosition: endPosition,
    itemKey: itemKey,
    item: item,
    capturedThemes: InheritedTheme.capture(from: context, to: navigator.context),
  ));
}

class _FlyingItemRoute extends PopupRoute {
  _FlyingItemRoute({
    required this.startPosition,
    required this.endPosition,
    required this.item,
    required this.itemKey,
    required this.capturedThemes,
    required this.onEnd,
  }) : super(traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop);

  final Offset startPosition;
  final Offset endPosition;
  final Widget item;
  final GlobalKey itemKey;
  final CapturedThemes capturedThemes;
  final void Function() onEnd;

  @override
  Animation<double> createAnimation() =>
      CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: const Interval(0.0, 1.0 / 3.0),
      );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 30);

  @override
  bool get barrierDismissible => false;

  @override
  Color? get barrierColor => null;

  @override
  final String barrierLabel = 'item';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final Widget flyingItem = _FlyingItem(
      key: UniqueKey(),
      route: this,
      itemKey: itemKey,
    );

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (context) {
          return TweenAnimationBuilder<Offset>(
            duration: const Duration(milliseconds: 800),
            tween: Tween<Offset>(begin: startPosition, end: endPosition),
            onEnd: () {
              Navigator.of(context).pop();
              onEnd();
            },
            builder: (context, position, _) {
              return CustomSingleChildLayout(
                delegate: _FlyingItemRouteLayout(
                  position,
                  mediaQuery.padding,
                ),
                child: capturedThemes.wrap(flyingItem),
              );
            },
          );
        },
      ),
    );
  }
}

class _FlyingItem extends StatelessWidget {
  const _FlyingItem({
    super.key,
    required this.itemKey,
    required this.route,
  });

  final GlobalKey itemKey;
  final _FlyingItemRoute route;

  @override
  Widget build(BuildContext context) {
    Widget child = FadeTransition(
      key: itemKey,
      opacity: CurvedAnimation(
        parent: route.animation!,
        curve: const Interval(0.0, 1.0 / 3.0),
      ),
      child: route.item,
    );

    final CurveTween opacity = CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = CurveTween(curve: const Interval(0.0, 0.1));
    final CurveTween height = CurveTween(curve: const Interval(0.0, 0.1));

    return AnimatedBuilder(
      animation: route.animation!,
      builder: (context, child) {
        return FadeTransition(
          opacity: opacity.animate(route.animation!),
          child: Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: AlignmentDirectional.center,
              widthFactor: width.evaluate(route.animation!),
              heightFactor: height.evaluate(route.animation!),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}

class _FlyingItemRouteLayout extends SingleChildLayoutDelegate {
  _FlyingItemRouteLayout(
      this.position,
      this.padding,
      );

  final Offset position;
  EdgeInsets padding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      BoxConstraints.loose(constraints.biggest);

  @override
  Offset getPositionForChild(Size size, Size childSize) => position;

  @override
  bool shouldRelayout(_FlyingItemRouteLayout oldDelegate) =>
      position != oldDelegate.position
          || padding != oldDelegate.padding;
}
