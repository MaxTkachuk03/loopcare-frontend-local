import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum DashboardNavbarItems {
  today,
  education,
  account,
}

extension DashboardNavbarItemsX on DashboardNavbarItems {
  String get label {
    switch (this) {
      case DashboardNavbarItems.today:
        return LocalizedTexts.today.translation;
      case DashboardNavbarItems.education:
        return LocalizedTexts.education.translation;
      case DashboardNavbarItems.account:
        return LocalizedTexts.account.translation;
    }
  }
}
