import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/progress_bar.dart';
import 'package:video_player/video_player.dart';

class GroupSessionPlayerOverlay extends StatefulWidget {
  final VideoPlayerController controller;
  final Orientation orientation;

  static const double _defaultVideoWidth = 1280.0;
  static const double _defaultVideoHeight = 720.0;

  const GroupSessionPlayerOverlay({
    Key? key,
    required this.controller,
    required this.orientation,
  }) : super(key: key);

  @override
  State<GroupSessionPlayerOverlay> createState() => _GroupSessionPlayerOverlayState();
}

class _GroupSessionPlayerOverlayState extends State<GroupSessionPlayerOverlay> {
  void _onSlideChangeHandler() {
    widget.controller.play();
  }

  bool get _isPortraitOrientation {
    return widget.orientation == Orientation.portrait;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.symmetric(
          horizontal: _isPortraitOrientation ? 20.0 : 60.0, vertical: _isPortraitOrientation ? 10.0 : 30.0),
      child: ProgressBar(
        controller: widget.controller,
        onSliderProgressChange: _onSlideChangeHandler,
      ),
    );
  }
}
