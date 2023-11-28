import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

enum DashboardNavbarItems {
  today(0, 'Today'),
  education(1, 'Education'),
  account(2, 'Account');

  const DashboardNavbarItems(this.number, this.value);

  static DashboardNavbarItems getValueByString(String val) => values.firstWhere((e) => e.value == val);

  static Color getColorByIndex(int index) => values.firstWhere((e) => e.index == index).color;

  final int number;
  final String value;

  get color {
    switch (value) {
      case 'Today':
        return AppColors.blueMid;
      case 'Education':
        return AppColors.orange;
      case 'Account':
        return AppColors.blueDark;
    }
  }

  get icon {
    switch (value) {
      case 'Today':
        return AppIcons.calendar;
      case 'Education':
        return AppIcons.book;
      case 'Account':
        return AppIcons.account;
    }
  }

  get activeIcon {
    switch (value) {
      case 'Today':
        return AppIcons.calendarFull;
      case 'Education':
        return AppIcons.bookFull;
      case 'Account':
        return AppIcons.accountFull;
    }
  }

  String label(String userName) {
    switch (value) {
      case 'Today':
        return value;
      case 'Education':
        return value;
      case 'Account':
        return userName;
      default:
        return '';
    }
  }
}
