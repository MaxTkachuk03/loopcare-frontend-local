import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button_with_icon.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

class EmergencyBtn extends StatelessWidget {
  final void Function() onPressHandler;

  const EmergencyBtn({super.key, required this.onPressHandler});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 201,
      child: CustomOutlinedButtonWithIcon.blue(
        onPressed: () => _onBtnPress,
        icon: AppIcons.sos,
        label: LocalizedTexts.inCaseOfEmergency.tr(),
      ),
    );
  }

  void _onBtnPress() {}
}
