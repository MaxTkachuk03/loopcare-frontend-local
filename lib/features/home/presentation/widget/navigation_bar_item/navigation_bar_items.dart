import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons_data.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum NavigationBarItems {
  practice(0),
  river(1),
  account(2);

  const NavigationBarItems(this.number);

  final int number;

  static Color getColorByIndex(int index) => values.elementAt(index).color;

  static SystemUiOverlayStyle getOverlayStyleByIndex(int index) =>
      values.elementAt(index).systemOverlayStyle;

  bool get isPractice => this == practice;

  bool get isProfile => this == account;

  String label(String userName) => switch (this) {
        practice => LocalizedTexts.practice.tr(),
        river => LocalizedTexts.pool.tr(),
        account => userName,
      };

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
