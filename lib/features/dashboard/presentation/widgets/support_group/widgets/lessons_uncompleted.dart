import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class LessonsUncompleted extends StatelessWidget {
  const LessonsUncompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText.w600(
      LocalizedTexts.unavailableGroupPrefsLabel.tr(),
      style: context.textTheme.bodySmall,
    );
  }
}
