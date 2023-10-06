import 'package:flutter/material.dart';
import 'package:flutter_zoom_videosdk/flutter_zoom_view.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';

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
            child: View(creationParams: {
              "userId": user.userId,
              "sharing": false,
              "preview": false,
              "focused": false,
              "hasMultiCamera": false,
              "videoAspect": VideoAspect.FullFilled,
              "fullScreen": false,
            }),
          ),
          Text(
            user.userName,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
