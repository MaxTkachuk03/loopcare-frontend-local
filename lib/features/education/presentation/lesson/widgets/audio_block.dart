import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/player_widget.dart';

class AudioBlock extends StatefulWidget {
  final void Function(int duration) onDurationChanged;
  final void Function(int position) onPositionChanged;
  final void Function(bool isPlay) onPlayingChanged;
  final void Function() onPlayerComplete;
  final String url;

  const AudioBlock({
    Key? key,
    required this.onDurationChanged,
    required this.onPositionChanged,
    required this.onPlayingChanged,
    required this.onPlayerComplete,
    required this.url,
  }) : super(key: key);

  @override
  State<AudioBlock> createState() => _AudioBlockState();
}

class _AudioBlockState extends State<AudioBlock> {
  AudioPlayer audioPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  List<StreamSubscription> streams = [];

  @override
  void initState() {
    streams.add(
      audioPlayer.onDurationChanged.listen((v) {
        widget.onDurationChanged(v.inMilliseconds);
      }),
    );

    streams.add(
      audioPlayer.onPositionChanged.listen(
        (v) {
          widget.onPositionChanged(v.inMilliseconds);
        },
      ),
    );

    streams.add(
      audioPlayer.onPlayerStateChanged.listen(
        (v) {
          widget.onPlayingChanged(v == PlayerState.playing);
        },
      ),
    );

    streams.add(
      audioPlayer.onPlayerComplete.listen(
        (v) {
          widget.onPlayerComplete();
        },
      ),
    );

    audioPlayer.setSourceDeviceFile(widget.url);

    super.initState();
  }

  @override
  void dispose() {
    for (var s in streams) {
      s.cancel();
    }
    audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlayerWidget(player: audioPlayer);
  }
}
