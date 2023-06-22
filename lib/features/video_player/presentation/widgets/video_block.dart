import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/video_error.dart';
import 'package:video_player/video_player.dart';

class VideoBlock extends StatelessWidget {
  static const double _defaultVideoWidth = 1280.0;
  static const double _defaultVideoHeight = 720.0;

  final Orientation orientation;
  final VideoPlayerController? controller;

  const VideoBlock({Key? key, required this.orientation, required this.controller}) : super(key: key);

  double get _videoWidth {
    final c = controller;
    if (c == null) return 0;

    final width = c.value.size.width;

    return width != 0 ? width : _defaultVideoWidth;
  }

  double get _videoHeight {
    final c = controller;
    if (c == null) return 0;
    final height = c.value.size.height;

    return height != 0 ? height : _defaultVideoHeight;
  }

  @override
  Widget build(BuildContext context) {
    return controller != null
        ? ValueListenableBuilder(
            valueListenable: controller!,
            builder: (BuildContext context, VideoPlayerValue value, child) {
              if (value.hasError) {
                return VideoError(
                    width: _videoWidth, height: _videoHeight, errorMessage: value.errorDescription);
              }

              if (!value.isInitialized) return const Center(child: Loader());

              return FittedBox(
                fit: orientation == Orientation.portrait ? BoxFit.cover : BoxFit.fill,
                child: SizedBox(
                  width: _videoWidth,
                  height: _videoHeight,
                  child: AspectRatio(
                    aspectRatio: value.aspectRatio,
                    child: VideoPlayer(controller!),
                  ),
                ),
              );
            },
          )
        : const Center(child: Loader());
  }
}
