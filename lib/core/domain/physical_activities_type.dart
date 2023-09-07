import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

enum PhysicalActivitiesType {
  buildUpMuscle,
  inceaseYourStamina,
}

extension PhysicalActivitiesTypeX on PhysicalActivitiesType {
  String get label {
    switch (this) {
      case PhysicalActivitiesType.buildUpMuscle:
        return LocalizedTexts.buildUpMuscle.tr().capitalize();
      case PhysicalActivitiesType.inceaseYourStamina:
        return LocalizedTexts.inceaseYourStamina.tr().capitalize();
    }
  }
}
