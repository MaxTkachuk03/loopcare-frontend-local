import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/features/education/domain/subtitle/image_subtitle_controller.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/player_widget.dart';

class AudioBlock extends StatefulWidget {
  final void Function() onPlayerComplete;
  final String url;
  final String audioPreviewImage;
  final String title;
  final int duration;
  final SubtitleController controller;

  const AudioBlock({
    super.key,
    required this.onPlayerComplete,
    required this.url,
    required this.audioPreviewImage,
    required this.title,
    required this.duration,
    required this.controller,
  });

  @override
  State<AudioBlock> createState() => _AudioBlockState();
}

class _AudioBlockState extends State<AudioBlock> with AutoRouteAware {
  AutoRouteObserver? _observer;

  AudioPlayer audioPlayer = AudioPlayer();

  List<StreamSubscription> streams = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _observer = RouterScope.of(context).firstObserverOfType<AutoRouteObserver>();
    if (_observer != null) {
      _observer?.subscribe(this, context.routeData);
    }
  }

  @override
  void didPushNext() {
    _stopPlayer();
  }

  @override
  void didPop() {
    _stopPlayer();
  }

  @override
  void initState() {
    streams.add(audioPlayer.durationStream.listen((state) {}));

    streams.add(
      audioPlayer.positionStream.listen(
        (v) {
          widget.controller.setActiveSubtitleItem(v.inMilliseconds);
        },
      ),
    );

    streams.add(
      audioPlayer.playerStateStream.listen(
        (v) {
          widget.controller.setIsPlaying(v.playing);
        },
      ),
    );

    streams.add(
      audioPlayer.processingStateStream.listen(
        (v) {
          if (v == ProcessingState.completed) {
            widget.onPlayerComplete();
          }
        },
      ),
    );

    super.initState();
    _setupPlayer();
  }

  @override
  void dispose() {
    for (var s in streams) {
      s.cancel();
    }
    audioPlayer.stop();
    _observer?.unsubscribe(this);
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _setupPlayer() async {
    try {
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse('file://${widget.url}'),
          tag: MediaItem(
            id: widget.url,
            title: widget.title,
            artUri: Uri.parse(widget.audioPreviewImage),
          ),
        ),
        initialPosition: Duration.zero,
        preload: true,
      );
    } catch (e) {
      // Fallback for all errors
      log.e(e.toString(), error: e.runtimeType);
    }
  }

  void _stopPlayer() {
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return PlayerWidget(player: audioPlayer);
  }
}
