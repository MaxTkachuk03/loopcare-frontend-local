import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:permission_handler/permission_handler.dart';

class NoPermissions extends StatelessWidget {
  const NoPermissions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText.w400(
              LocalizedTexts.allowCameraMessage.tr(),
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            CustomElevatedButton(
              label: LocalizedTexts.openSettings.tr(),
              onPressed: openAppSettings,
            ),
          ],
        ),
      ),
    );
  }
}
