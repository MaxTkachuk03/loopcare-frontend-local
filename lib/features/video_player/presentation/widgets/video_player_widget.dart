import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/player_overlay.dart';
import 'package:video_player/video_player.dart';

// Video information (exercise metadata) - DONE with the mocked data
// Navigate in play list
// Seek to the moment in the video (skip explanation)
// Errors handling
// Progress bar with possible to seek to the video position video length - DONE
// Play / pause - DONE
// Show metadata and controls when user click on video and hide after a while - DONE
// Disable screen - DONE
// Mute audio - DONE
// Horizontal and vertical layout - DONE

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final Orientation orientation;

  const VideoPlayerWidget({super.key, required this.controller, required this.orientation});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  static const Duration _timerDuration = Duration(seconds: 3);
  static const Duration _animationDuration = Duration(milliseconds: 350);

  Timer? _timer;
  bool _showControls = false;

  _onVideoPressedHandler() {
    if (_timer != null) _timer?.cancel();

    _timer = Timer.periodic(_timerDuration, (timer) {
      setState(() {
        _showControls = false;
      });

      timer.cancel();
    });

    setState(() {
      _showControls = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.value.isInitialized
        ? GestureDetector(
            onTap: _onVideoPressedHandler,
            child: Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: widget.controller.value.size.width,
                    height: widget.controller.value.size.height,
                    child: AspectRatio(
                      aspectRatio: widget.controller.value.aspectRatio,
                      child: VideoPlayer(widget.controller),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: _animationDuration,
                  opacity: _showControls ? 1 : 0,
                  child: PlayerOverlay(controller: widget.controller, orientation: widget.orientation),
                ),
              ],
            ),
          )
        : const Center(child: Loader());
  }
}
