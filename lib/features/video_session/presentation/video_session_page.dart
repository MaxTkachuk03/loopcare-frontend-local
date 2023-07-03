import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/video_info.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/video_session_app_bar.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/video_session_bottom.dart';

class VideoSessionPage extends StatelessWidget {
  const VideoSessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VideoSessionAppBar(
        title: 'Looking at eating behavior',
        subtitle: 'Duration 0:21:23',
        actions: [
          IconButton(
            iconSize: 40,
            onPressed: () => {},
            icon: const Image(image: AppIcons.phone),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: ScrollableContainer(
          child: Column(
            children: const [
              Image(image: AppImages.videoSession),
              VideoInfo(),
              VideoSessionBottom(),
            ],
          ),
        ),
      ),
    );
  }
}
