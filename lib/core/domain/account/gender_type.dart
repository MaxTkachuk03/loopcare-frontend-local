import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum GenderType {
  woman(LocalizedTexts.woman),
  man(LocalizedTexts.man),
  other(LocalizedTexts.other);

  const GenderType(this.title);

  final String title;
}
