import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Duration _kCardDuration = Duration(milliseconds: 300);
const double _kCardCloseIntervalEnd = 2.0 / 3.0;
const double _kCardMaxWidth = 6.0 * _kCardWidthStep;
const double _kCardMinWidth = 2.0 * _kCardWidthStep;
const double _kCardWidthStep = 60.0;
const double _kCardScreenPadding = 8.0;

class _PopupCard<T> extends StatelessWidget {
  const _PopupCard({
    super.key,
    required this.route,
    required this.semanticLabel,
    this.constraints,
  });

  final _PopupCardRoute route;
  final String? semanticLabel;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final CurveTween opacity = CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = CurveTween(curve: const Interval(0.0, 1.0));
    final CurveTween height = CurveTween(curve: const Interval(0.0, 1.0));

    final Widget child = ConstrainedBox(
      constraints: constraints ??
          const BoxConstraints(
            minWidth: _kCardMinWidth,
            maxWidth: _kCardMaxWidth,
          ),
      child: IntrinsicWidth(
        stepWidth: _kCardWidthStep,
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: semanticLabel,
          child: route.content,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: route.animation!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: opacity.animate(route.animation!),
          child: Material(
            shape: route.shape ?? popupMenuTheme.shape,
            color: route.color ?? popupMenuTheme.color,
            type: MaterialType.card,
            elevation: route.elevation ?? popupMenuTheme.elevation ?? 8.0,
            child: Align(
              alignment: AlignmentDirectional.topEnd,
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

/// Positioning of the menu on the screen.
class _PopupCardRouteLayout extends SingleChildLayoutDelegate {
  _PopupCardRouteLayout(
    this.position,
    this.textDirection,
    this.padding,
    this.avoidBounds,
  );

  /// Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  /// Whether to prefer going to the left or to the right.
  final TextDirection textDirection;

  /// The padding of unsafe area.
  EdgeInsets padding;

  /// List of rectangles that we should avoid overlapping. Unusable screen area.
  final Set<Rect> avoidBounds;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest).deflate(
      const EdgeInsets.all(_kCardScreenPadding) + padding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // Find the ideal vertical position.
    final double y = position.top;

    // Find the ideal horizontal position.
    double x;
    if (position.left > position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    } else {
      // Menu button is equidistant from both edges, so grow in reading direction.
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }
    final Offset wantedPosition = Offset(x, y);
    final Offset originCenter = position.toRect(Offset.zero & size).center;
    final Iterable<Rect> subScreens = DisplayFeatureSubScreen.subScreensInBounds(
      Offset.zero & size,
      avoidBounds,
    );
    final Rect subScreen = _closestScreen(subScreens, originCenter);
    return _fitInsideScreen(subScreen, childSize, wantedPosition);
  }

  Rect _closestScreen(Iterable<Rect> screens, Offset point) {
    Rect closest = screens.first;
    for (final Rect screen in screens) {
      if ((screen.center - point).distance < (closest.center - point).distance) {
        closest = screen;
      }
    }
    return closest;
  }

  Offset _fitInsideScreen(Rect screen, Size childSize, Offset wantedPosition) {
    double x = wantedPosition.dx;
    double y = wantedPosition.dy;
    // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // edge of the screen in every direction.
    if (x < screen.left + _kCardScreenPadding + padding.left) {
      x = screen.left + _kCardScreenPadding + padding.left;
    } else if (x + childSize.width > screen.right - _kCardScreenPadding - padding.right) {
      x = screen.right - childSize.width - _kCardScreenPadding - padding.right;
    }
    if (y < screen.top + _kCardScreenPadding + padding.top) {
      y = _kCardScreenPadding + padding.top;
    } else if (y + childSize.height > screen.bottom - _kCardScreenPadding - padding.bottom) {
      y = screen.bottom - childSize.height - _kCardScreenPadding - padding.bottom;
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupCardRouteLayout oldDelegate) {
    return position != oldDelegate.position ||
        textDirection != oldDelegate.textDirection ||
        padding != oldDelegate.padding ||
        !setEquals(avoidBounds, oldDelegate.avoidBounds);
  }
}

class _PopupCardRoute extends PopupRoute {
  _PopupCardRoute({
    required this.position,
    required this.content,
    this.elevation,
    required this.barrierLabel,
    this.semanticLabel,
    this.shape,
    this.color,
    required this.capturedThemes,
    this.constraints,
  });

  final RelativeRect position;
  final Widget content;
  final double? elevation;
  final String? semanticLabel;
  final ShapeBorder? shape;
  final Color? color;
  final CapturedThemes capturedThemes;
  final BoxConstraints? constraints;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kCardCloseIntervalEnd),
    );
  }

  @override
  Duration get transitionDuration => _kCardDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget card = _PopupCard(
      route: this,
      semanticLabel: semanticLabel,
      constraints: constraints,
    );
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _PopupCardRouteLayout(
              position,
              Directionality.of(context),
              mediaQuery.padding,
              _avoidBounds(mediaQuery),
            ),
            child: capturedThemes.wrap(card),
          );
        },
      ),
    );
  }

  Set<Rect> _avoidBounds(MediaQueryData mediaQuery) {
    return DisplayFeatureSubScreen.avoidBounds(mediaQuery).toSet();
  }
}

/// Show a popup card that contains the custom widget at `position`.
Future<void> showCard<T>({
  required BuildContext context,
  required RelativeRect position,
  required Widget content,
  double elevation = 12,
  String? semanticLabel,
  ShapeBorder? shape,
  Color? color,
  bool useRootNavigator = false,
  BoxConstraints? constraints,
}) {
  assert(debugCheckHasMaterialLocalizations(context));

  switch (Theme.of(context).platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      semanticLabel ??= 'Popup card';
  }

  final NavigatorState navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  return navigator.push(
    _PopupCardRoute(
      position: position,
      content: content,
      elevation: elevation,
      semanticLabel: semanticLabel,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      shape: shape,
      color: color,
      capturedThemes: InheritedTheme.capture(from: context, to: navigator.context),
      constraints: constraints,
    ),
  );
}
