import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

enum LessonCategory {
  all,
  general,
  nutrition,
  mind,
  activity,
}

extension LessonCategoryX on LessonCategory {
  String get label {
    switch (this) {
      case LessonCategory.all:
        return LocalizedTexts.all.tr().capitalize();
      case LessonCategory.general:
        return LocalizedTexts.general.tr().capitalize();
      case LessonCategory.nutrition:
        return LocalizedTexts.nutrition.tr().capitalize();
      case LessonCategory.mind:
        return LocalizedTexts.mind.tr().capitalize();
      case LessonCategory.activity:
        return LocalizedTexts.activity.tr().capitalize();
    }
  }
}
