import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

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

  String get apiValue {
    switch (this) {
      case PhysicalActivitiesType.buildUpMuscle:
        return 'Build up muscles';
      case PhysicalActivitiesType.inceaseYourStamina:
        return 'Increase you stamina';
    }
  }

  int get index {
    switch (this) {
      case PhysicalActivitiesType.buildUpMuscle:
        return 0;
      case PhysicalActivitiesType.inceaseYourStamina:
        return 1;
    }
  }
}
