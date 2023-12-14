import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

class LessonsUncompleted extends StatelessWidget {
  const LessonsUncompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocalizedTexts.unavailableGroupPrefsLabel,
      style: Theme.of(context).textTheme.bodySmall,
    ).tr();
  }
}
