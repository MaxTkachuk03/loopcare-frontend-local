import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session_program_event.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/video_player/application/video_player_bloc.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/group_session_player_overlay.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/video_block.dart';
import 'package:video_player/video_player.dart';

class SessionVideoContainer extends StatefulWidget {
  final int sessionTimer;
  final void Function(bool) onVideoPlayingListener;
  final Orientation orientation;

  const SessionVideoContainer(
      {super.key,
      required this.sessionTimer,
      required this.onVideoPlayingListener,
      required this.orientation});

  @override
  State<SessionVideoContainer> createState() => _SessionVideoContainerState();
}

class _SessionVideoContainerState extends State<SessionVideoContainer> with WidgetsBindingObserver {
  static const double _defaultVideoWidth = 1280.0;
  static const double _defaultVideoHeight = 720.0;

  bool _videoIsPlaying = false;
  VideoPlayerController? _videoPlayerController;

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

    final videoEventForCurrentTime = videoEvents.lastWhereOrNull((e) => widget.sessionTimer == 5);

    if (videoEventForCurrentTime == null) return;

    _initVideoController(videoEventForCurrentTime.videoPath!);
  }

  void _initVideoController(String videoLink) {
    final headers = context.read<VideoPlayerBloc>().state.data.videoHttpHeaders;

    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse("https://d316h49i7nayz2.cloudfront.net/Lunges/index.m3u8"),
        httpHeaders: headers)
      ..initialize().then((value) {
        _videoPlayerController?.play();
      }).whenComplete(() {
        setState(() {
          _videoIsPlaying = true;
        });
        widget.onVideoPlayingListener(true);
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

  void _onVideoEnds() {
    final oldController = _videoPlayerController;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await oldController?.dispose();
    });

    _videoPlayerController = null;

    _videoIsPlaying = false;

    widget.onVideoPlayingListener(false);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController == null
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
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoBlock(controller: _videoPlayerController, orientation: widget.orientation),
                      GroupSessionPlayerOverlay(
                        controller: _videoPlayerController!,
                        orientation: widget.orientation,
                      )
                    ],
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
