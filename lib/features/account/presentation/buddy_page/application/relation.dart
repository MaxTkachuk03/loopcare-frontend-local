import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

enum Relation {
  husband_or_wife,
  child,
  parent,
  family,
  friend,
}

extension RelationX on Relation {
  String get label {
    switch (this) {
      case Relation.husband_or_wife:
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

Relation getRelation(String name) {
  if (name == Relation.husband_or_wife.name) {
    return Relation.husband_or_wife;
  } else if (name == Relation.child.name) {
    return Relation.child;
  } else if (name == Relation.parent.name) {
    return Relation.parent;
  } else if (name == Relation.family.name) {
    return Relation.family;
  }
  return Relation.friend;
}
