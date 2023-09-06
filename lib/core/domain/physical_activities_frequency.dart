import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

enum PhysicalActivitiesFrequency {
  oneTime,
  twoTimes,
  threeTimes,
  fourTimes,
  fiveTimes,
  notAble,
}

extension PhysicalActivitiesFrequencyX on PhysicalActivitiesFrequency {
  String get label {
    switch (this) {
      case PhysicalActivitiesFrequency.oneTime:
        return LocalizedTexts.physicalActivitiesFrequencyItemOne.tr().capitalize();
      case PhysicalActivitiesFrequency.twoTimes:
        return LocalizedTexts.physicalActivitiesFrequencyItemTwo.tr().capitalize();
      case PhysicalActivitiesFrequency.threeTimes:
        return LocalizedTexts.physicalActivitiesFrequencyItemThree.tr().capitalize();
      case PhysicalActivitiesFrequency.fourTimes:
        return LocalizedTexts.physicalActivitiesFrequencyItemFour.tr().capitalize();
      case PhysicalActivitiesFrequency.fiveTimes:
        return LocalizedTexts.physicalActivitiesFrequencyItemFive.tr().capitalize();
      case PhysicalActivitiesFrequency.notAble:
        return LocalizedTexts.physicalActivitiesFrequencyItemSix.tr().capitalize();
    }
  }

  bool get recommended {
    switch (this) {
      case PhysicalActivitiesFrequency.oneTime:
        return false;
      case PhysicalActivitiesFrequency.twoTimes:
        return false;
      case PhysicalActivitiesFrequency.threeTimes:
        return true;
      case PhysicalActivitiesFrequency.fourTimes:
        return false;
      case PhysicalActivitiesFrequency.fiveTimes:
        return false;
      case PhysicalActivitiesFrequency.notAble:
        return false;
    }
  }
}
