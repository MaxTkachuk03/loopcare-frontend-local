import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/seek_bar.dart';
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
      // widget.player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          widget.player.positionStream,
          widget.player.bufferedPositionStream,
          widget.player.durationStream,
          (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  final ValueNotifier<bool> muteNotifier;

  const ControlButtons(this.player, this.muteNotifier, {super.key});

  _onPlayPressed(BuildContext context) {
    final lessonId = context.read<EducationLessonBloc>().state.data.id;

    AnalyticsEventService.instance.lessonAudioPlayEvent(lessonId);

    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            FirebaseEvents.lessonAudioPlay,
            {
              CustomDefinitions.lessonId: lessonId.toString(),
              CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

    player.play();
  }

  _onPlayPaused(BuildContext context) {
    final lessonId = context.read<EducationLessonBloc>().state.data.id;

    AnalyticsEventService.instance.lessonAudioStopEvent(lessonId);

    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            FirebaseEvents.lessonAudioStop,
            {
              CustomDefinitions.lessonId: lessonId.toString(),
              CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

    player.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 50),
        SizedBox(
          height: 50,
          width: 50,
          child: StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  width: 30.0,
                  height: 30.0,
                  child: const CircularProgressIndicator(
                    color: AppColors.darkGreen,
                  ),
                );
              } else if (playing != true) {
                return CustomIconButton(
                  icon: const Icon(Icons.play_arrow, size: 35, color: AppColors.blueRegular),
                  onPressed: () => _onPlayPressed(context),
                );
              } else if (processingState != ProcessingState.completed) {
                return CustomIconButton(
                  icon: const Icon(Icons.pause, size: 35, color: AppColors.blueRegular),
                  onPressed: () => _onPlayPaused(context),
                );
              } else {
                return CustomIconButton(
                  icon: const Icon(Icons.replay, size: 35, color: AppColors.blueRegular),
                  onPressed: () => player.seek(Duration.zero),
                );
              }
            },
          ),
        ),

        ValueListenableBuilder<bool>(
          valueListenable: muteNotifier,
          builder: (context, isMute, _) {
            return CustomIconButton(
              key: const Key('mute_button'),
              onPressed: _handleMute,
              icon: Icon(
                isMute ? Icons.volume_off : Icons.volume_up,
                size: 30,
                color: AppColors.blueRegular,
              ),
            );
          },
        ),
        // Opens speed slider dialog
      ],
    );
  }

  void _handleMute() {
    player.setVolume(muteNotifier.value ? 1 : 0);

    muteNotifier.value = !muteNotifier.value;
  }
}
