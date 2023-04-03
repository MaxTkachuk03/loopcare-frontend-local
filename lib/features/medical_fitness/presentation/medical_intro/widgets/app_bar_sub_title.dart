import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AppBarSubTitle extends StatelessWidget {
  final int? currentNumber;
  final int? total;

  const AppBarSubTitle({
    Key? key,
    this.currentNumber,
    this.total,
  }) : super(key: key);

  String getText() {
    if (currentNumber != null && total != null) {
      return '${LocalizedTexts.mentalHealth.tr()}: $currentNumber of $total';
    }

    return LocalizedTexts.mentalHealth.tr();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getText(),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: ThemeConstants.fontSize14,
          ),
    );
  }
}
