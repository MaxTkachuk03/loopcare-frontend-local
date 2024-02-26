import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/infrastructure/services/screen_name_mapper.dart';

/// Override [FirebaseAnalyticsObserver]
class FirebaseNavigatorObserver extends AutoRouterObserver {
  final int userId;
  final FirebaseAnalytics analytics;
  final ScreenNameExtractor nameExtractor;
  final RouteFilter routeFilter;
  final void Function(PlatformException error)? _onError;

  FirebaseNavigatorObserver({
    required this.analytics,
    required this.userId,
    this.nameExtractor = defaultNameExtractor,
    this.routeFilter = defaultRouteFilter,
    Function(PlatformException error)? onError,
  }) : _onError = onError;

  void _sendScreenView(RouteSettings settings) {
    final String? screenName = screenNames[nameExtractor(settings)] ?? nameExtractor(settings);

    if (screenName != null) {
      analytics.logEvent(
        name: 'screen_view',
        parameters: {
          'userId': userId,
          'screenName': screenName,
        },
      ).catchError(catchErrorOnErrorCb, test: (Object error) => error is PlatformException);
    }
  }

  catchErrorOnErrorCb(Object error) {
    final error = _onError;
    if (error == null) {
      debugPrint('$FirebaseAnalyticsObserver: $error');
    } else {
      error(error as PlatformException);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (routeFilter(route)) {
      _sendScreenView(route.settings);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null && routeFilter(newRoute)) {
      _sendScreenView(newRoute.settings);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null && routeFilter(previousRoute) && routeFilter(route)) {
      _sendScreenView(previousRoute.settings);
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    super.didChangeTabRoute(route, previousRoute);
    _sendScreenView(RouteSettings(name: route.name));
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    super.didInitTabRoute(route, previousRoute);
    _sendScreenView(RouteSettings(name: route.name));
  }
}
