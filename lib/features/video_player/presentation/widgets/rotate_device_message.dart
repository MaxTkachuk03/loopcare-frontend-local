import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class RotateDeviceMessage extends StatelessWidget {
  const RotateDeviceMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcons.telephone,
          const SizedBox(height: 22.0),
          const Text(
            LocalizedTexts.rotateDevice,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.white),
            textAlign: TextAlign.center,
          ).tr(),
        ],
      ),
    );
  }
}
