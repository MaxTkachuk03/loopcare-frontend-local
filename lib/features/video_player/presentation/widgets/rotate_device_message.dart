import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

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
          CustomText.w400(
            LocalizedTexts.rotateDevice.tr(),
            style: context.textTheme.bodyLarge?.copyWith(color: AppColors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
