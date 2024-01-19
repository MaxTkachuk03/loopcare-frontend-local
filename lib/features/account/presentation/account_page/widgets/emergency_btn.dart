import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button_with_icon.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

class EmergencyBtn extends StatelessWidget {
  final bool? needBackgroundColor;

  const EmergencyBtn({
    super.key,
    this.needBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 201,
      child: CustomOutlinedButtonWithIcon.blue(
        needBackgroundColor: needBackgroundColor,
        onPressed: () => _onBtnPress(context),
        icon: AppIcons.sos,
        label: LocalizedTexts.inCaseOfEmergency.tr(),
      ),
    );
  }

  void _onBtnPress(BuildContext context) {
    ModalBottomSheet.emergencyNumbers(context: context);
  }
}
