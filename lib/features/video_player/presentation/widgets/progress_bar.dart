import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:video_player/video_player.dart';

class ProgressBar extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onSliderProgressChange;

  const ProgressBar({
    Key? key,
    required this.controller,
    required this.onSliderProgressChange,
  }) : super(key: key);

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  double _durationToDouble(Duration val) {
    return val.inMilliseconds.toDouble();
  }

  void _onSeekHandler(double val) {
    onSliderProgressChange();
    controller.seekTo(Duration(microseconds: (val * 1000).toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ValueListenableBuilder(
            valueListenable: controller,
            builder: (BuildContext context, VideoPlayerValue value, child) {
              return Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Slider(
                        activeColor: AppColors.blueMid,
                        inactiveColor: AppColors.greyMid,
                        onChanged: _onSeekHandler,
                        min: 0,
                        max: _durationToDouble(value.duration),
                        value: _durationToDouble(value.position),
                      ),
                    ),
                    Text(
                      _videoDuration(value.duration - value.position),
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
