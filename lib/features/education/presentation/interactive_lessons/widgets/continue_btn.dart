import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class ContinueBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isDisable;

  const ContinueBtn(
      {super.key, required this.onPressed, required this.isDisable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: CustomElevatedButton.blueFullWidth(
        onPressed: isDisable ? null : onPressed,
        label: LocalizedTexts.continueBtn.tr(),
      ),
    );
  }
}
