import 'package:flutter/material.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum LikeUnlikeOptions {
  no(1, 'No'),
  yes(2, 'Yes');

  const LikeUnlikeOptions(this.number, this.value);

  final int number;
  final String value;

  Widget get icon => switch (this) {
        no => const Icon(Icons.thumb_down_alt_outlined),
        _ => const Icon(Icons.thumb_up_alt_outlined),
      };

  Widget get iconSelected => switch (this) {
        no => const Icon(Icons.thumb_down_alt_rounded),
        _ => const Icon(Icons.thumb_up_alt_rounded),
      };

  String get label => switch (this) {
        no => LocalizedTexts.notReally.tr(),
        _ => LocalizedTexts.yesYes.tr(),
      };

  bool get toBool => this == yes;
}
