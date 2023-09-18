import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/common.dart';
import 'package:rxdart/rxdart.dart';

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const PlayerWidget({
    required this.player,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState();
  }
}

class _PlayerWidgetState extends State<PlayerWidget> with WidgetsBindingObserver {
  final ValueNotifier<bool> _muteNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    widget.player.dispose();
    _muteNotifier.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      widget.player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      widget.player.positionStream,
      widget.player.bufferedPositionStream,
      widget.player.durationStream,
      (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Display seek bar. Using StreamBuilder, this widget rebuilds
          // each time the position, buffered position or duration changes.
          StreamBuilder<PositionData>(
            stream: _positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                duration: positionData?.duration ?? Duration.zero,
                position: positionData?.position ?? Duration.zero,
                bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                onChangeEnd: widget.player.seek,
              );
            },
          ),
          ControlButtons(widget.player, _muteNotifier),
        ],
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  final ValueNotifier<bool> muteNotifier;

  const ControlButtons(this.player, this.muteNotifier, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        Center(
          child: StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  width: 30.0,
                  height: 30.0,
                  child: const CircularProgressIndicator(
                    color: AppColors.darkGreen,
                  ),
                );
              } else if (playing != true) {
                return IconButton(
                  icon: const Icon(Icons.play_arrow),
                  color: AppColors.darkGreen,
                  iconSize: 35.0,
                  onPressed: player.play,
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: const Icon(Icons.pause),
                  iconSize: 35.0,
                  color: AppColors.darkGreen,
                  onPressed: player.pause,
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.replay),
                  iconSize: 35.0,
                  color: AppColors.darkGreen,
                  onPressed: () => player.seek(Duration.zero),
                );
              }
            },
          ),
        ),

        Positioned(
          right: 16,
          child: ValueListenableBuilder<bool>(
            valueListenable: muteNotifier,
            builder: (context, isMute, _) {
              return IconButton(
                key: const Key('mute_button'),
                onPressed: _handleMute,
                iconSize: 30.0,
                icon: Icon(isMute ? Icons.volume_off : Icons.volume_up),
                color: AppColors.darkGreen,
              );
            },
          ),
        ),
        // Opens speed slider dialog
      ],
    );
  }

  void _handleMute() {
    if (muteNotifier.value) {
      player.setVolume(1);
    } else {
      player.setVolume(0);
    }
    muteNotifier.value = !muteNotifier.value;
  }
}
