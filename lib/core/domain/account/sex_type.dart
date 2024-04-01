import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum SexType {
  male(LocalizedTexts.male),
  female(LocalizedTexts.female);

  const SexType(this.title);

  final String title;
}
