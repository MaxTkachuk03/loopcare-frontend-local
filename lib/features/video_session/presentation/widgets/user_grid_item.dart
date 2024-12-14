import 'package:flutter/material.dart';
import 'package:flutter_zoom_videosdk/flutter_zoom_view.dart' as zoom;
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/user_default_avatar.dart';

class UserGridItem extends StatelessWidget {
  final ZoomVideoSdkUser user;
  final bool isTalking;
  final bool isCameraOff;

  const UserGridItem(
      {super.key, required this.user, required this.isTalking, required this.isCameraOff});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 2.5, color: isTalking ? AppColors.orangeRegular : Colors.transparent),
            color: AppColors.black,
          ),
          child: ClipRect(
            child: OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: SizedBox(
                  width: size.width / 3,
                  height: size.height / 3,
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
              ),
            ),
          ),
        ),
        if (isCameraOff) const UserDefaultAvatar(),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: CustomText.w400(
                user.userName,
                style: context.textTheme.bodySmall?.copyWith(color: Colors.white),
              )),
        )
      ],
    );
  }
}
