import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/duration_extensions.dart';
import 'package:video_player/video_player.dart';

class ProgressBar extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onSliderProgressChange;

  const ProgressBar({
    super.key,
    required this.controller,
    required this.onSliderProgressChange,
  });

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
              if (!value.isInitialized) return const SizedBox.shrink();

              return Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Slider(
                        activeColor: AppColors.blueMid,
                        inactiveColor: AppColors.greyMid,
                        secondaryActiveColor: AppColors.ballBlue,
                        onChanged: _onSeekHandler,
                        min: 0,
                        max: _durationToDouble(value.duration),
                        value: _durationToDouble(value.position),
                        secondaryTrackValue: value.buffered.isEmpty ? 0.0 : _durationToDouble(value.buffered[0].end),
                      ),
                    ),
                    Text(
                      (value.duration - value.position).toVideoDurationString,
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
