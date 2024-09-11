part of '../mind_video_screen.dart';

const double _pinSize = 20.0;
const double _halfPinSize = 10.0;

const double _contentPadding = 20.0;
const double _defaultBottomPadding = 16.0;

const double _iconSize = 42.0;

const Color _playedColor = AppColors.yellowRegular;
const Color _bufferedColor = AppColors.greyLight;
const Color _backgroundColor = AppColors.greyRegular;

class _VideoProgressControl extends StatelessWidget {
  const _VideoProgressControl({
    super.key,
    required this.controller,
    required this.playingListener,
    required this.onPlayPressed,
    this.bottomPadding = _defaultBottomPadding,
    this.contentTitle,
  });

  final VideoPlayerController controller;
  final ValueListenable<bool> playingListener;
  final void Function() onPlayPressed;
  final double bottomPadding;
  final RichText? contentTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: bottomPadding,
        left: _contentPadding,
        right: _contentPadding,
        top: _contentPadding,
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.transparent,
          Colors.black54,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: playingListener,
            builder: (context, isPlaying, _) {
              if (contentTitle != null && !isPlaying) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      width: 275.0,
                      child: contentTitle!,
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          _CustomVideoProgressIndicator(
            controller,
            key: const ValueKey('video_progress_line'),
          ),
          const SizedBox(height: 8),
          IconButton(
            onPressed: onPlayPressed,
            icon: ValueListenableBuilder<bool>(
              valueListenable: playingListener,
              builder: (context, isPlaying, _) {
                return Icon(
                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: AppColors.white,
                  size: _iconSize,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomVideoScrubber extends StatefulWidget {
  const _CustomVideoScrubber({
    super.key,
    required this.child,
    required this.controller,
  });

  final Widget child;
  final VideoPlayerController controller;

  @override
  State<_CustomVideoScrubber> createState() => _CustomVideoScrubberState();
}

class _CustomVideoScrubberState extends State<_CustomVideoScrubber> {
  bool _controllerWasPlaying = false;

  VideoPlayerController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    void seekToRelativePosition(Offset globalPosition) {
      final RenderBox box = context.findRenderObject()! as RenderBox;
      final Offset tapPos = box.globalToLocal(globalPosition);
      final double relative = tapPos.dx / box.size.width;
      final Duration position = controller.value.duration * relative;
      controller.seekTo(position);
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: widget.child,
      onHorizontalDragStart: (DragStartDetails details) {
        if (!controller.value.isInitialized) {
          return;
        }
        _controllerWasPlaying = controller.value.isPlaying;
        if (_controllerWasPlaying) {
          controller.pause();
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (!controller.value.isInitialized) {
          return;
        }
        seekToRelativePosition(details.globalPosition);
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_controllerWasPlaying && controller.value.position != controller.value.duration) {
          controller.play();
        }
      },
      onTapDown: (TapDownDetails details) {
        if (!controller.value.isInitialized) {
          return;
        }
        seekToRelativePosition(details.globalPosition);
      },
    );
  }
}

class _CustomVideoProgressIndicator extends StatefulWidget {
  const _CustomVideoProgressIndicator(this.controller, {super.key});

  final VideoPlayerController controller;

  @override
  State<_CustomVideoProgressIndicator> createState() => _CustomVideoProgressIndicatorState();
}

class _CustomVideoProgressIndicatorState extends State<_CustomVideoProgressIndicator> {
  _CustomVideoProgressIndicatorState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  late VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget progressIndicator;
    String time = '00:00';

    if (controller.value.isInitialized) {
      final int duration = controller.value.duration.inMilliseconds;
      final int position = controller.value.position.inMilliseconds;

      int maxBuffering = 0;
      for (final DurationRange range in controller.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }

      progressIndicator = LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: 30,
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                Positioned(
                  top: _halfPinSize,
                  bottom: _halfPinSize,
                  left: _halfPinSize,
                  right: _halfPinSize,
                  child: LinearProgressIndicator(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    value: maxBuffering / duration,
                    valueColor: const AlwaysStoppedAnimation<Color>(_bufferedColor),
                    backgroundColor: _backgroundColor,
                  ),
                ),
                Positioned(
                  top: _halfPinSize,
                  bottom: _halfPinSize,
                  left: _halfPinSize,
                  right: _halfPinSize,
                  child: LinearProgressIndicator(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    value: position / duration,
                    valueColor: const AlwaysStoppedAnimation<Color>(_playedColor),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 10),
                  top: 5,
                  left: (constraints.maxWidth - _pinSize) * (position / duration),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: _playedColor,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox.square(dimension: _pinSize),
                  ),
                )
              ],
            ),
          );
        },
      );

      final timer = Duration(milliseconds: duration - position);

      time =
          '${timer.inMinutes.toString().padLeft(2, '0')} : ${(timer.inSeconds - timer.inMinutes * 60).toString().padLeft(2, '0')}';
    } else {
      progressIndicator = const LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(_playedColor),
        backgroundColor: _backgroundColor,
      );
    }

    progressIndicator = _CustomVideoScrubber(
      key: const ValueKey('video_scrubber'),
      controller: controller,
      child: progressIndicator,
    );

    return Row(
      children: [
        Expanded(child: progressIndicator),
        const SizedBox(width: 8),
        SizedBox(
          width: 64,
          child: CustomText.w400(
            time,
            textAlign: TextAlign.right,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
