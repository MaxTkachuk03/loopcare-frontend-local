import 'package:flutter/material.dart';
import 'package:flutter_zoom_videosdk/flutter_zoom_view.dart' as zoom;
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class UserGridItemAndroid extends StatelessWidget {
  final ZoomVideoSdkUser user;

  const UserGridItemAndroid({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: zoom.View(creationParams: {
              "userId": user.userId,
              "sharing": false,
              "preview": false,
              "focused": false,
              "hasMultiCamera": false,
              "videoAspect": VideoAspect.FullFilled,
              "fullScreen": false,
            }),
          ),
          CustomText.w400(
            user.userName,
            style: context.textTheme.bodySmall?.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
