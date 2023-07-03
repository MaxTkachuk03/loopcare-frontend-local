import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class VideoSessionBottom extends StatelessWidget {
  const VideoSessionBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF232323),
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => {},
                  child: Column(
                    children: [
                      AppIcons.microphone,
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        'Mute',
                        style: TextStyle(
                          fontSize: ThemeConstants.fontSize11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40.0,
                ),
                InkWell(
                  onTap: () => {},
                  child: Column(
                    children: [
                      AppIcons.cameraOff,
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        'Stop video',
                        style: TextStyle(
                          fontSize: ThemeConstants.fontSize11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () => {},
              child: Column(
                children: [
                  AppIcons.settings,
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: ThemeConstants.fontSize11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
