import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum YesNoAnswer {
  yes(value: true),
  no(value: false);

  const YesNoAnswer({required this.value});

  final bool value;

  String get label => switch (this) {
        yes => LocalizedTexts.yes.tr().capitalize(),
        no => LocalizedTexts.no.tr().capitalize(),
      };
}
