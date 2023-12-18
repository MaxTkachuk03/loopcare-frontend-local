import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class EmergencyBtn extends StatelessWidget {
  final void Function() onPressHandler;

  const EmergencyBtn({super.key, required this.onPressHandler});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 201,
      child: ElevatedButton(
        onPressed: () {},
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), side: const BorderSide(color: AppColors.darkGreen)),
              ),
            ),
        child: InkWell(
          onTap: () => ModalBottomSheet.emergencyNumbers(
            context: context,
            onBtnPress: () => _onBtnPress,
          ),
          child: Row(
            children: [
              AppIcons.sos,
              const SizedBox(width: 8.0),
              const Text(
                LocalizedTexts.inCaseOfEmergency,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGreen,
                ),
              ).tr(), // <-- Text
            ],
          ),
        ),
      ),
    );
  }

  void _onBtnPress() {}
}
