import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class ContinueBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isDisable;
  final String? label;
  final double? bottom;

  const ContinueBtn(
      {super.key, required this.onPressed, required this.isDisable, this.label, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: bottom ?? 30),
      child: CustomElevatedButton.blueFullWidth(
        onPressed: isDisable ? null : onPressed,
        label: label ?? LocalizedTexts.continueBtn.tr(),
      ),
    );
  }
}
