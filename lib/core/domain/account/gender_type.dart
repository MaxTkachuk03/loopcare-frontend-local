import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum GenderType {
  woman(LocalizedTexts.woman),
  man(LocalizedTexts.man),
  other(LocalizedTexts.other);

  const GenderType(this.title);

  final String title;
}
