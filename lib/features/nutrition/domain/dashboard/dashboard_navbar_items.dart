import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum DashboardNavbarItems {
  overview,
  explore,
  account,
}

extension DashboardNavbarItemsX on DashboardNavbarItems {
  String get label {
    switch (this) {
      case DashboardNavbarItems.overview:
        return LocalizedTexts.overview.translation;
      case DashboardNavbarItems.explore:
        return LocalizedTexts.explore.translation;
      case DashboardNavbarItems.account:
        return LocalizedTexts.account.translation;
    }
  }
}
