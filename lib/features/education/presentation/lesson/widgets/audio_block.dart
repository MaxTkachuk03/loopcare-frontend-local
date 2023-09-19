import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';

// import 'package:audioplayers/audioplayers.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/player_widget.dart';
import 'package:loopcare_frontend/injection.dart';

class AudioBlock extends StatefulWidget {
  final void Function(int duration) onDurationChanged;
  final void Function(int position) onPositionChanged;
  final void Function(bool isPlay) onPlayingChanged;
  final void Function() onPlayerComplete;
  final String url;
  final int duration;

  const AudioBlock({
    Key? key,
    required this.onDurationChanged,
    required this.onPositionChanged,
    required this.onPlayingChanged,
    required this.onPlayerComplete,
    required this.url,
    required this.duration,
  }) : super(key: key);

  @override
  State<AudioBlock> createState() => _AudioBlockState();
}

class _AudioBlockState extends State<AudioBlock> {
  AudioPlayer audioPlayer = AudioPlayer();

  List<StreamSubscription> streams = [];

  @override
  void initState() {
    streams.add(audioPlayer.durationStream.listen((state) {
      widget.onDurationChanged(state?.inMilliseconds ?? 0);
    }));

    streams.add(
      audioPlayer.positionStream.listen(
        (v) {
          widget.onPositionChanged(v.inMilliseconds);
        },
      ),
    );

    streams.add(
      audioPlayer.playerStateStream.listen(
        (v) {
          widget.onPlayingChanged(v.playing);
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
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _setupPlayer() async {
    final authManager = getIt<AuthTokenManager>();
    final token = await authManager.getAccessToken();
    try {
      await audioPlayer.setUrl(widget.url, headers: {'Authorization': 'Bearer $token'});
      var duration = await audioPlayer.load();
      if (duration == null || duration == Duration.zero) {
        audioPlayer.setClip(start: const Duration(seconds: 0), end:  Duration(seconds: widget.duration));
      }
      debugPrint('devcpp duration: $duration');
    } on PlayerException catch (e) {
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // Linux/Windows: maps to PlayerErrorCode.index
      debugPrint('devcpp Error code: ${e.code}');
      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web/Linux: a generic message
      // Windows: MediaPlayerError.message
      debugPrint('devcpp Error message: ${e.message}');
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
      debugPrint('devcpp Connection aborted: ${e.message}');
    } catch (e) {
      // Fallback for all errors
      debugPrint('devcpp $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlayerWidget(player: audioPlayer);
  }
}
