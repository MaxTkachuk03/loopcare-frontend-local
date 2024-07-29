import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons_data.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

enum NavigationBarItems {
  practice(0, 'Practice'),
  river(1, 'River'),
  account(2, 'Profile');

  const NavigationBarItems(this.number, this.label);

  final int number;
  final String label;

  static Color getColorByIndex(int index) => values.elementAt(index).color;

  static SystemUiOverlayStyle getOverlayStyleByIndex(int index) => values.elementAt(index).systemOverlayStyle;

  bool get isPractice => this == practice;

  bool get isProfile => this == account;

  Color get color => switch (this) {
        practice => AppColors.blueRegular,
        river => AppColors.blueLightest,
        account => AppColors.blueRegular,
      };

  SystemUiOverlayStyle get systemOverlayStyle => switch (this) {
        practice => SystemUiOverlayStyle.light,
        river => SystemUiOverlayStyle.dark,
        account => SystemUiOverlayStyle.light,
      };

  IconData get icon => switch (this) {
        practice => AppIconsData.iPractice,
        river => AppIconsData.iEducation,
        account => AppIconsData.iProfile,
      };

  static NavigationBarItems itemAtIndex(int index) =>
      NavigationBarItems.values.firstWhere((e) => index == e.number);
}

List<NavigationBarItems> get bottomTabs => [
      NavigationBarItems.practice,
      NavigationBarItems.river,
      NavigationBarItems.account,
    ];
