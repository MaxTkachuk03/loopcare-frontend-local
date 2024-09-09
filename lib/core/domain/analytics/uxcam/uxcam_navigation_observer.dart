import 'package:flutter/widgets.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:loopcare_frontend/core/infrastructure/services/screen_name_mapper.dart' as app;

/// Override [FlutterUxcamNavigatorObserver]
/// ---------------------------------------------------------------------------
/// Here using NavigatorObserver instead of [RouteObserver] because
/// [RouteObserver] only works for Navigator 1.0 and will log nothing
/// or perform no calls in case of Navigator 2.0.
class UxcamNavigationObserver extends NavigatorObserver {
  /// Using this approach as we need to keep track of screens
  /// before this one and keep track of screens previous to the
  /// current one.
  List<String> screenNames = [];

  /// Using this to chech for and store latest Screen Name
  String taggingScreen = '';

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final screenName = screenNameExtractor(route);

    /// This line of code is required as there are scenarios where we have
    /// routing like in popup menu but it is not handled by routing in
    /// [onGenerateRoute].
    if (screenName != null) {
      screenNames.add(screenName);
      setAndTaggingScreenName();
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final screenName = screenNameExtractor(newRoute);
    screenNames.remove(screenName);
    setAndTaggingScreenName();
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final screenName = screenNameExtractor(route);
    screenNames.remove(screenName);
    setAndTaggingScreenName();
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    final screenName = screenNameExtractor(route);
    screenNames.remove(screenName);
    setAndTaggingScreenName();
    super.didRemove(route, previousRoute);
  }

  /// This function will just perform operation for setting [taggingScreen] and
  /// depeding on the value of [taggingScreen] will either discard or perform
  /// [FlutterUxcam.tagScreenName] operation.
  void setAndTaggingScreenName() {
    taggingScreen = screenNames.isNotEmpty ? screenNames.last : '';
    if (taggingScreen.isNotEmpty) {
      FlutterUxcam.tagScreenName(taggingScreen);
    }
  }

  String? screenNameExtractor(Route<dynamic>? route) => app.getScreenName(route?.settings.name);
}
