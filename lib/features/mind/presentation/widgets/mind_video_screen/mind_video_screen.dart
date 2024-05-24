import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/application/system_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_video_screen/widgets/hiding_box.dart';
import 'package:loopcare_frontend/features/video_player/presentation/widgets/rotate_device_message.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'widgets/_orientation_state_video_wrapper.dart';
part 'widgets/_play_pause_button.dart';
part 'widgets/_video_app_bar.dart';
part 'widgets/_video_progress_control.dart';

class MindVideoScreen extends StatefulWidget {
  const MindVideoScreen({
    super.key,
    required this.title,
    required this.onPop,
    required this.url,
    required this.videoOrientation,
    required this.onCompleted,
    required this.skipButtonLabel,
    required this.onSkip,
    required this.contentTitle,
    required this.onCompleteOverlay,
  });

  final String title;
  final String url;
  final void Function() onCompleted;
  final void Function() onPop;
  final void Function()? onSkip;
  final String skipButtonLabel;
  final Orientation videoOrientation;
  final RichText contentTitle;
  final Widget? onCompleteOverlay;

  @override
  State<MindVideoScreen> createState() => _MindVideoScreenState();
}

class _MindVideoScreenState extends State<MindVideoScreen> {
  late VideoPlayerController _videoController;
  bool _initialised = false;
  final _playingNotifier = ValueNotifier<bool>(false);
  double _bottomPadding = _defaultBottomPadding;
  bool _isCompleted = false;

  Future<void> _initVideoPlayerController() async {
    await WakelockPlus.enable();

    final url = Uri.parse(widget.url);
    _videoController = VideoPlayerController.networkUrl(url);

    await _videoController.initialize();
    _initialised = true;

    if (widget.videoOrientation == Orientation.landscape) {
      SystemService.allowBothOrientations();
    }

    _videoController.addListener(_videoCompleteListener);

    // Replace loading overlay with video
    setState(() {});
  }

  void _videoCompleteListener() {
    _playingNotifier.value = _videoController.value.isPlaying;

    if (_videoController.value.isCompleted) {
      _onComplete();
    }
  }

  void _onComplete() {
    // WidgetsBinding - run too fast and crash with _videoController call after
    // dispose() called is appeared. So that is why we use Future.delayed
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_isCompleted) {
        widget.onCompleted();
        _isCompleted = true;
      }

      if (widget.onCompleteOverlay != null) {
        _videoController.pause();

        // Add widget.onCompleteOverlay on screen. Set [_isCompleted]
        // parameter for UI
        setState(() {});
      }
    });
  }

  Future<void> _onlyPortraitOrientation() async {
    await WakelockPlus.disable();

    SystemService.allowOnlyPortraitOrientation();
    SystemService.showSystemOverlays();
  }

  void _togglePlay() {
    if (!_isCompleted) {
      _playingNotifier.value = !_videoController.value.isPlaying;
      _videoController.value.isPlaying ? _videoController.pause() : _videoController.play();
    }
  }

  _OrientationsState _getOrientationState(Orientation orientation) {
    if (orientation == Orientation.portrait && widget.videoOrientation == Orientation.portrait) {
      return _OrientationsState.allPortrait;
    } else if (orientation == Orientation.landscape && widget.videoOrientation == Orientation.landscape) {
      return _OrientationsState.allLandscape;
    } else if (orientation == Orientation.portrait && widget.videoOrientation == Orientation.landscape) {
      return _OrientationsState.mixedPortrait;
    } else {
      return _OrientationsState.mixedLandscape;
    }
  }

  void _orientationChangeHandler(_OrientationsState orientation) {
    if (orientation.isAllPortrait) {
      _bottomPadding = _defaultBottomPadding;
      SystemService.hideSystemOverlaysButTop();
    } else if (orientation.isAllLandscape) {
      _bottomPadding = 0;
      SystemService.hideSystemOverlays();
    } else if (orientation.isMixedPortrait) {
      _bottomPadding = _defaultBottomPadding;
      SystemService.showSystemOverlays();
    } else {
      _bottomPadding = 0;
      SystemService.showSystemOverlays();
    }
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayerController();
  }

  @override
  void dispose() {
    _onlyPortraitOrientation();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar = _VideoAppBar(
      key: const ValueKey('video_screen_app_bar'),
      title: widget.title,
      topPadding: mediaQuery.viewPadding.top,
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => widget.onPop(),
      child: Scaffold(
        backgroundColor: AppColors.blueDarker,
        appBar: !_initialised
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: appBar,
              )
            : null,
        body: Builder(
          builder: (context) {
            if (!_initialised) {
              return const Loader();
            }

            final enableCompletedState = _isCompleted && widget.onCompleteOverlay != null;
            return OrientationBuilder(builder: (context, orientation) {
              final orientationState = _getOrientationState(orientation);

              _orientationChangeHandler(orientationState);

              return GestureDetector(
                onTap: _togglePlay,
                child: Stack(
                  children: [
                    _OrientationStateVideoWrapper(
                      key: const ValueKey('video-container'),
                      orientationsState: orientationState,
                      screenSize: mediaQuery.size,
                      child: AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      ),
                    ),
                    if (!enableCompletedState)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _playingNotifier,
                          builder: (context, isPlaying, _) {
                            return HidingBox(
                              isPlay: isPlaying,
                              child: _VideoProgressControl(
                                key: const ValueKey('video_screen_progress_control'),
                                controller: _videoController,
                                contentTitle: widget.contentTitle,
                                onPlayPressed: _togglePlay,
                                playingListener: _playingNotifier,
                                bottomPadding: mediaQuery.viewPadding.bottom + _bottomPadding,
                              ),
                            );
                          },
                        ),
                      ),
                    if (widget.onSkip != null && !enableCompletedState)
                      Positioned(
                        top: mediaQuery.viewPadding.top + kToolbarHeight + 30,
                        right: 20,
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _playingNotifier,
                          builder: (context, isPlaying, _) {
                            return IgnorePointer(
                              ignoring: isPlaying,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: isPlaying ? 0.0 : 1.0,
                                child: CustomElevatedButton.yellowSmall(
                                  label: widget.skipButtonLabel,
                                  onPressed: widget.onSkip,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _playingNotifier,
                      builder: (context, isPlaying, _) {
                        return Center(
                          child: _PlayPauseButton(
                            key: const ValueKey('video_screen_play_pause_button'),
                            isPlay: isPlaying,
                          ),
                        );
                      },
                    ),
                    if (enableCompletedState)
                      Positioned.fill(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isCompleted ? 1 : 0,
                          child: ColoredBox(
                            color: Colors.black45,
                            child: widget.onCompleteOverlay!,
                          ),
                        ),
                      ),
                    Positioned(
                      height: mediaQuery.viewPadding.top + kToolbarHeight,
                      top: 0,
                      left: 0,
                      right: 0,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _playingNotifier,
                        builder: (context, isPlaying, _) {
                          return HidingBox(
                            isPlay: isPlaying,
                            child: appBar,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}

enum _OrientationsState {
  /// Video and Screen [Orientation] is same. And is [Orientation.portrait]
  allPortrait,

  /// Video and Screen [Orientation] is same. And is [Orientation.landscape]
  allLandscape,

  /// Video has [Orientation.landscape] and Screen is [Orientation.portrait]
  mixedPortrait,

  /// Video has [Orientation.portrait] and Screen is [Orientation.landscape]
  mixedLandscape;

  bool get isMixed => this == mixedPortrait || this == mixedLandscape;

  bool get isNotMixed => this == allPortrait || this == allLandscape;

  bool get isAllPortrait => this == allPortrait;

  bool get isAllLandscape => this == allLandscape;

  bool get isMixedPortrait => this == mixedPortrait;

  bool get isMixedLandscape => this == mixedLandscape;
}
