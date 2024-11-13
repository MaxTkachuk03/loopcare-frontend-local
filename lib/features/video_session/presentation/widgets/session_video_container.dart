import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/duration_extensions.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session_program_event.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/video_player/application/video_player_bloc.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/group_session_video_error.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/rotate_device_message.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/video_block.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:video_player/video_player.dart';

class SessionVideoContainer extends StatefulWidget {
  final int sessionTimer;
  final void Function(bool) onVideoPlayingListener;
  final Orientation orientation;

  const SessionVideoContainer({
    super.key,
    required this.sessionTimer,
    required this.onVideoPlayingListener,
    required this.orientation,
  });

  @override
  State<SessionVideoContainer> createState() => _SessionVideoContainerState();
}

class _SessionVideoContainerState extends State<SessionVideoContainer> with WidgetsBindingObserver {
  VideoPlayerController? _videoPlayerController;
  GroupSessionProgramEvent? _currentVideoEvent;

  bool _videoIsPlaying = false;
  bool _closedVideo = false;
  bool _visibility = false;
  final List<int> _completedEventsIds = [];

  int get userId => getIt<SharedStorageService>().account!.id;

  String get userName => getIt<SharedStorageService>().account!.name;

  String get userNickname => getIt<SharedStorageService>().account!.nickname ?? '';

  bool get _shouldNotUpdate => _videoIsPlaying || _closedVideo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkIfHasVideoForCurrentTime();
  }

  @override
  void didUpdateWidget(covariant SessionVideoContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_shouldNotUpdate) return;

    _checkIfHasVideoForCurrentTime();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      _videoPlayerController?.setVolume(0.0);
    }

    if (state == AppLifecycleState.resumed) {
      _syncVideoState();
      _videoPlayerController?.setVolume(1.0);
    }
  }

  void _syncVideoState() {
    final currentEvent = _currentVideoEvent;

    if (currentEvent == null) return;

    final bool isVideoInProgress = currentEvent.eventStartTime <= widget.sessionTimer &&
        widget.sessionTimer <= currentEvent.eventEndTime;

    final bool isVideoEnds = widget.sessionTimer > currentEvent.eventEndTime;

    if (isVideoEnds) {
      _onVideoEnds();
    }

    if (isVideoInProgress) {
      _videoPlayerController
          ?.seekTo(Duration(seconds: widget.sessionTimer - currentEvent.eventStartTime));
    }
  }

  void _checkIfHasVideoForCurrentTime() {
    final List<GroupSessionProgramEvent> videoEvents =
        context.read<TopicsBloc>().state.data.videoEvents;
    final videoEventForCurrentTime = videoEvents.lastWhereOrNull(
        (e) => e.eventStartTime <= widget.sessionTimer && widget.sessionTimer <= e.eventEndTime);
    if (videoEventForCurrentTime == null ||
        _completedEventsIds.contains(videoEventForCurrentTime.id)) return;
    setState(() {
      _currentVideoEvent = videoEventForCurrentTime;
    });
    _loadVideoPlayer(videoEventForCurrentTime.videoPath!);
  }

  _loadVideoPlayer(String videoLink) {
    if (_videoPlayerController == null) {
      _initVideoController(videoLink);
    } else {
      final oldController = _videoPlayerController;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController?.dispose();
        _initVideoController(videoLink);
      });
      setState(() {
        _videoPlayerController = null;
      });
    }
  }

  void _initVideoController(String videoLink) {
    final headers = context.read<VideoPlayerBloc>().state.data.videoHttpHeaders;
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoLink),
        httpHeaders: headers, videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))
      ..initialize().then((value) {
        final bool isVideoInProgress =
            (_currentVideoEvent?.eventStartTime ?? 0) <= widget.sessionTimer &&
                widget.sessionTimer <= (_currentVideoEvent?.eventEndTime ?? 0);
        final int startPosition =
            isVideoInProgress ? widget.sessionTimer - (_currentVideoEvent?.eventStartTime ?? 0) : 0;

        _videoPlayerController
          ?..seekTo(Duration(seconds: startPosition))
          ..play();
      }).whenComplete(() {
        final currentVideoEvent = _currentVideoEvent;

        if (currentVideoEvent != null) {
          _completedEventsIds.add(currentVideoEvent.id);
        }

        setState(() {
          _videoIsPlaying = true;
          _visibility = true;
        });
        widget.onVideoPlayingListener(true);
      });
  }

  void _onVideoEnds() {
    final controller = _videoPlayerController;

    if (controller == null) return;

    if (controller.value.isPlaying) controller.pause();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _videoIsPlaying = false;
        _closedVideo = false;
        _visibility = false;
      });

      widget.onVideoPlayingListener(false);
    });
  }

  void _onVideoClose() {
    final controller = _videoPlayerController;

    if (controller == null) return;

    if (controller.value.isPlaying) controller.pause();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _videoIsPlaying = false;
        _closedVideo = true;
        _visibility = false;
      });

      widget.onVideoPlayingListener(false);
    });
  }

  void onUpdateHandler() {
    final video = _currentVideoEvent;

    if (video == null) return;

    _loadVideoPlayer(video.videoPath!);
  }

  bool get _isPortrait => widget.orientation == Orientation.portrait;

  Widget _errorWidgetCb(double width, double height, String? error) => GroupSessionVideoError(
        width: width,
        height: height,
        errorMessage: error,
        onUpdate: onUpdateHandler,
        onClose: _onVideoClose,
      );

  @override
  Widget build(BuildContext context) {
    final controller = _videoPlayerController;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: _visibility ? 1 : 0,
      child: Visibility(
        visible: _visibility,
        child: Container(
          color: AppColors.black,
          child: Column(
            children: [
              if (_isPortrait) const Expanded(child: RotateDeviceMessage()),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    VideoBlock(
                      controller: controller,
                      orientation: widget.orientation,
                      errorWidget: _errorWidgetCb,
                    ),
                    if (controller != null && controller.value.isInitialized)
                      ValueListenableBuilder(
                        valueListenable: controller,
                        builder: (BuildContext context, VideoPlayerValue value, child) {
                          final videoFinished =
                              value.isInitialized && value.position == value.duration;

                          if (videoFinished) _onVideoEnds();

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: _isPortrait ? 20.0 : 60.0,
                                  vertical: 20.0,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: VideoProgressIndicator(
                                        controller,
                                        allowScrubbing: false,
                                        colors: const VideoProgressColors(
                                          playedColor: AppColors.anotherBlue,
                                          bufferedColor: AppColors.c6c5c5,
                                          backgroundColor: AppColors.d9d9d9,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    CustomText.w400(
                                      (value.duration - value.position).toDurationString,
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(color: AppColors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
              ),
              if (_isPortrait) const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  _disposeVideoController() {
    final controller = _videoPlayerController;

    if (controller == null) return;

    if (controller.value.isPlaying) _videoPlayerController?.pause();

    controller.dispose();
  }

  @override
  void dispose() {
    _disposeVideoController();

    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}
