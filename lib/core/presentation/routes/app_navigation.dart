// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@immutable
class AppNavigator {
  const AppNavigator._();

  static bool canPop(BuildContext context) => context.router.canPop();

  static Future<dynamic> pushNamed(BuildContext context, String path) => context.router.pushNamed(path);

  static Future<dynamic> pushNamedAndRemoveUntil(
    BuildContext context,
    String path, {
    required RoutePredicate predicate,
  }) {
    context.router.popUntil(predicate);
    return context.router.pushNamed(path);
  }

  static Future<dynamic> pushTo(BuildContext context, Widget widget) => context.router.pushWidget(widget);

  static Future<dynamic> pushNamedAndReplace(BuildContext context, String path) => context.router.replaceNamed(path);

  static Future<E?> pushReplaceRoute<E>(BuildContext context, PageRouteInfo route) => context.router.replace<E>(route);

  static Future<E?> pushAndPopUntil<E>(BuildContext context, PageRouteInfo route,
          {required RoutePredicate predicate}) =>
      context.router.pushAndPopUntil<E>(route, predicate: predicate);

  static Future<E?> pushRoute<E>(BuildContext context, PageRouteInfo route) => context.router.push<E>(route);

  static Future<dynamic> pushNamedAndClearStack(BuildContext context, String path) {
    context.router.popUntilRoot();
    return context.router.replaceNamed(path);
  }

  static Future<dynamic> pop<T extends Object?>(BuildContext context, [T? result]) async {
    if (context.router.stack.length == 1) {
      context.router.navigateNamed('/');
      return;
    }
    context.router.pop(result);
  }

  static void setTabIndex(BuildContext context, int index) {
    return context.tabsRouter.setActiveIndex(index);
  }

  static int activeTabIndex(BuildContext context) {
    return context.tabsRouter.activeIndex;
  }
}
