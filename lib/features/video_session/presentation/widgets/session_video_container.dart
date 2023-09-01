import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session_program_event.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/video_player/application/video_player_bloc.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/group_session_video_error.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/video_block.dart';
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
  static const double _defaultVideoWidth = 1280.0;
  static const double _defaultVideoHeight = 720.0;

  bool _videoIsPlaying = false;
  VideoPlayerController? _videoPlayerController;
  GroupSessionProgramEvent? _currentVideoEvent;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    _checkIfHasVideoForCurrentTime();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant SessionVideoContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_videoIsPlaying) return;

    _checkIfHasVideoForCurrentTime();
  }

  void _checkIfHasVideoForCurrentTime() {
    final List<GroupSessionProgramEvent> videoEvents = context.read<TopicsBloc>().state.data.videoEvents;

    final videoEventForCurrentTime = videoEvents.lastWhereOrNull(
        (e) => e.eventStartTime <= widget.sessionTimer && widget.sessionTimer <= e.eventEndTime);

    if (videoEventForCurrentTime == null) return;

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
        final bool isVideoInProgress = (_currentVideoEvent?.eventStartTime ?? 0) <= widget.sessionTimer &&
            widget.sessionTimer <= (_currentVideoEvent?.eventEndTime ?? 0);
        final int startPosition =
            isVideoInProgress ? widget.sessionTimer - (_currentVideoEvent?.eventStartTime ?? 0) : 0;

        _videoPlayerController
          ?..seekTo(Duration(seconds: startPosition))
          ..play();
      }).whenComplete(() {
        setState(() {
          _videoIsPlaying = true;
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
      });

      widget.onVideoPlayingListener(false);
    });
  }

  double get _videoWidth {
    final width = _videoPlayerController?.value.size.width;

    return width != 0 && width != null ? width : _defaultVideoWidth;
  }

  double get _videoHeight {
    final height = _videoPlayerController?.value.size.height;

    return height != 0 && height != null ? height : _defaultVideoHeight;
  }

  void onUpdateHandler() {
    final video = _currentVideoEvent;

    if (video == null) return;

    _loadVideoPlayer(video.videoPath!);
  }

  @override
  Widget build(BuildContext context) {
    final controller = _videoPlayerController;

    return controller == null || !_videoIsPlaying
        ? const SizedBox.shrink()
        : Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: widget.orientation == Orientation.portrait ? 0 : 1,
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (BuildContext context, VideoPlayerValue value, child) {
                      if (value.hasError) {
                        return GroupSessionVideoError(
                          width: _videoWidth,
                          height: _videoHeight,
                          errorMessage: value.errorDescription,
                          onUpdate: onUpdateHandler,
                          onClose: _onVideoEnds,
                        );
                      }

                      final videoFinished = value.isInitialized && value.position == value.duration;

                      if (videoFinished) _onVideoEnds();

                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          VideoBlock(controller: controller, orientation: widget.orientation),
                          VideoProgressIndicator(
                            padding: EdgeInsets.symmetric(
                              horizontal: widget.orientation == Orientation.portrait ? 20.0 : 60.0,
                              vertical: 20.0,
                            ),
                            controller,
                            allowScrubbing: false,
                            colors: const VideoProgressColors(
                              playedColor: AppColors.blueMid,
                              bufferedColor: AppColors.ballBlue,
                              backgroundColor: AppColors.greyMid,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
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
