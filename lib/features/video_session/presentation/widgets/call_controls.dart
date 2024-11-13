import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class CallControls extends StatelessWidget {
  final void Function() onMuteHandler;
  final void Function() onStopVideoHandler;
  final void Function() onSettingsHandler;
  final bool isMuted;
  final bool isCameraOn;

  const CallControls({
    super.key,
    required this.onMuteHandler,
    required this.onStopVideoHandler,
    required this.onSettingsHandler,
    required this.isMuted,
    required this.isCameraOn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blueDarker,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                child: CustomIconButton.custom(
                  onPressed: onMuteHandler,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isMuted ? AppIcons.microphoneOff : AppIcons.microphoneOn,
                      const SizedBox(height: 8.0),
                      CustomText.w600(
                        LocalizedTexts.mute.tr(),
                        style: context.textTheme.bodySmall?.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24.0),
              SizedBox(
                child: CustomIconButton.custom(
                  onPressed: onStopVideoHandler,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isCameraOn ? AppIcons.cameraOn : AppIcons.cameraOff,
                      const SizedBox(height: 8.0),
                      CustomText.w600(
                        LocalizedTexts.stopVideo.tr(),
                        style: context.textTheme.bodySmall?.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            child: CustomIconButton.custom(
              onPressed: onSettingsHandler,
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcons.settings,
                  const SizedBox(height: 8.0),
                  CustomText.w600(
                    LocalizedTexts.settings.tr(),
                    style: context.textTheme.bodySmall?.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
