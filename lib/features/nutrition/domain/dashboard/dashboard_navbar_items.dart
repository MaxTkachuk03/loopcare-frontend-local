import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

enum DashboardNavbarItems {
  today(0, 'Today'),
  education(1, 'Education'),
  chat(2, 'Group chat'),
  account(3, 'Account');

  const DashboardNavbarItems(this.number, this.value);

  bool get isGroupChat => value == chat.value;

  static DashboardNavbarItems getValueByString(String val) => values.firstWhere((e) => e.value == val);

  static Color getColorByIndex(int index) => values.firstWhere((e) => e.index == index).color;

  final int number;
  final String value;

  get color {
    switch (value) {
      case 'Today':
        return AppColors.blueRegular;
      case 'Education':
        return AppColors.petrolRegular;
      case 'Group chat':
        return AppColors.orangeRegular;
      case 'Account':
        return AppColors.blueRegular;
    }
  }

  get icon {
    switch (value) {
      case 'Today':
        return AppIcons.dashboardCalendar;
      case 'Education':
        return AppIcons.dashboardEducation;
      case 'Group chat':
        return AppIcons.dashboardChat;
      case 'Account':
        return AppIcons.dashboardAccount;
    }
  }

  get activeIcon {
    switch (value) {
      case 'Today':
        return AppIcons.dashboardCalendarActive;
      case 'Education':
        return AppIcons.dashboardEducationActive;
      case 'Group chat':
        return AppIcons.dashboardChatActive;
      case 'Account':
        return AppIcons.dashboardAccountActive;
    }
  }

  String label(String userName) {
    switch (value) {
      case 'Today':
        return value;
      case 'Education':
        return value;
      case 'Group chat':
        return value;
      case 'Account':
        return userName;
      default:
        return '';
    }
  }
}

List<PageRouteInfo<dynamic>> dashboardContent({bool enableChat = false}) => enableChat
    ? [
        const DashboardRoute(),
        const EducationRoute(),
        const GroupChatRoute(),
        const AccountRoute(),
      ]
    : [
        const DashboardRoute(),
        const EducationRoute(),
        const AccountRoute(),
      ];

List<DashboardNavbarItems> bottomTabs({bool enableChat = false}) => enableChat
    ? [
        DashboardNavbarItems.today,
        DashboardNavbarItems.education,
        DashboardNavbarItems.chat,
        DashboardNavbarItems.account
      ]
    : [DashboardNavbarItems.today, DashboardNavbarItems.education, DashboardNavbarItems.account];
