import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum LikeUnlikeOptions {
  no(1, 'No'),
  yes(2, 'Yes');

  const LikeUnlikeOptions(this.number, this.value);

  final int number;
  final String value;

  Widget get icon {
    switch (value) {
      case 'No':
        return const Icon(Icons.thumb_down_alt_outlined);
      case 'Yes':
        return const Icon(Icons.thumb_up_alt_outlined);
      default:
        return const Icon(Icons.thumb_up_alt_outlined);
    }
  }

  Widget get iconSelected {
    switch (value) {
      case 'No':
        return const Icon(Icons.thumb_down_alt_rounded);
      case 'Yes':
        return const Icon(Icons.thumb_up_alt_rounded);
      default:
        return const Icon(Icons.thumb_up_alt_rounded);
    }
  }

  String get label {
    switch (value) {
      case 'No':
        return LocalizedTexts.notReally.tr();
      case 'Yes':
        return LocalizedTexts.yesYes.tr();
      default:
        return LocalizedTexts.yesYes.tr();
    }
  }

  bool get toBool {
    switch (value) {
      case 'No':
        return false;
      case 'Yes':
        return true;
      default:
        return false;
    }
  }
}
