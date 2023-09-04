import 'package:flutter/material.dart';
import 'package:flutter_zoom_videosdk/flutter_zoom_view.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class UserGridItem extends StatelessWidget {
  final ZoomVideoSdkUser user;
  final bool isTalking;

  const UserGridItem({super.key, required this.user, required this.isTalking});

  @override
  Widget build(BuildContext context) {
    print('render UserGridItem');
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.5, color: isTalking ? AppColors.orange : Colors.transparent),
        color: AppColors.black,
      ),
      child: Stack(
        children: [
          View(creationParams: {
            "userId": user.userId,
            "sharing": false,
            "preview": false,
            "focused": false,
            "hasMultiCamera": false,
            "videoAspect": VideoAspect.FullFilled,
            "fullScreen": false,
          }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                user.userName,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
