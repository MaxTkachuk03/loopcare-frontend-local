import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

enum Relation {
  partner,
  child,
  parent,
  family,
  friend,
}

extension RelationX on Relation {
  String get label {
    switch (this) {
      case Relation.partner:
        return LocalizedTexts.buddyPartner.tr().capitalize();
      case Relation.child:
        return LocalizedTexts.buddyChild.tr().capitalize();
      case Relation.parent:
        return LocalizedTexts.buddyParent.tr().capitalize();
      case Relation.family:
        return LocalizedTexts.buddyFamily.tr().capitalize();
      case Relation.friend:
        return LocalizedTexts.buddyFriend.tr().capitalize();
    }
  }
}
