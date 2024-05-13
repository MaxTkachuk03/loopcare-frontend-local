part of '../mind_video_screen.dart';

class _PlayPauseButton extends StatefulWidget {
  const _PlayPauseButton({super.key, required this.isPlay});

  final bool isPlay;

  @override
  State<_PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<_PlayPauseButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _sizeAnimation;
  late IconData icon;

  @override
  void initState() {
    super.initState();
    _toggleIcon();
    _controller = AnimationController(
      reverseDuration: const Duration(milliseconds: 300),
      duration: const Duration(microseconds: 1),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 0.9).animate(_controller);
    _sizeAnimation = Tween<double>(begin: 120.0, end: 60.0).animate(_controller);
  }

  void _toggleIcon() {
    if (widget.isPlay) {
      icon = Icons.play_circle_rounded;
    } else {
      icon = Icons.pause_circle_filled_rounded;
    }
  }

  @override
  void didUpdateWidget(covariant _PlayPauseButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPlay != widget.isPlay) {
      _toggleIcon();
      _controller.reverse(from: 1);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Icon(
            icon,
            size: _sizeAnimation.value,
            color: Colors.white70,
          ),
        );
      },
    );
  }
}