import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:video_player/video_player.dart';

class PlayerControls extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onNextPressed;
  final VoidCallback onPrevPressed;

  const PlayerControls({
    Key? key,
    required this.controller,
    required this.onPrevPressed,
    required this.onNextPressed,
  }) : super(key: key);

  void _muteAudio() {
    controller.setVolume(0);
  }

  void _unMuteAudio() {
    controller.setVolume(1);
  }

  void _onMuteToggleHandler(VideoPlayerValue value) {
    value.volume > 0 ? _muteAudio() : _unMuteAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onPrevPressed,
                icon: const Icon(
                  Icons.skip_previous,
                  size: 35.0,
                  color: AppColors.white,
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (BuildContext context, VideoPlayerValue value, child) {
                    final videoEnds = !value.isPlaying && value.position == value.duration;

                    return IconButton(
                      onPressed: value.isPlaying ? controller.pause : controller.play,
                      icon: Icon(
                        !value.isPlaying || videoEnds ? Icons.play_arrow : Icons.pause,
                        size: 35.0,
                        color: AppColors.white,
                      ),
                    );
                  }),
              IconButton(
                onPressed: onNextPressed,
                icon: const Icon(
                  Icons.skip_next,
                  size: 35.0,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
            valueListenable: controller,
            builder: (BuildContext context, VideoPlayerValue value, child) {
              final isMuted = value.volume == 0;

              return Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => _onMuteToggleHandler(value),
                  icon: Icon(
                    isMuted ? Icons.volume_off : Icons.volume_up,
                    size: 35.0,
                    color: AppColors.white,
                  ),
                ),
              );
            }),
      ],
    );
  }
}
