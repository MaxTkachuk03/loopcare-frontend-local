import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum SexType {
  male(LocalizedTexts.male),
  female(LocalizedTexts.female);

  const SexType(this.title);

  final String title;
}
