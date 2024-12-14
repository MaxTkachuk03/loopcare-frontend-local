import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isCurrentRouteActive => ModalRoute.of(this)?.isCurrent ?? false;
}
