import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

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
      color: AppColors.black,
      padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                  onPressed: onMuteHandler,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TODO use AppIcons.microphone when the off icon will be provided
                      isMuted ? const Icon(Icons.mic_off) : const Icon(Icons.mic),
                      const SizedBox(height: 8.0),
                      const Text(
                        LocalizedTexts.mute,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.white),
                      ).tr(),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24.0),
              SizedBox(
                width: 60,
                height: 60,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                  onPressed: onStopVideoHandler,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TODO use AppIcons.cameraOff when the on icon will be provided
                      isCameraOn
                          ? const Icon(Icons.videocam_rounded)
                          : const Icon(Icons.videocam_off_rounded),
                      const SizedBox(height: 8.0),
                      const Text(
                        LocalizedTexts.stopVideo,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.white),
                      ).tr(),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
              onPressed: onSettingsHandler,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcons.settings,
                  const SizedBox(height: 8.0),
                  const Text(
                    LocalizedTexts.settings,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.white),
                  ).tr(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
