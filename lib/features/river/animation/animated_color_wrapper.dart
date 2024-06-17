import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/river_module_item/river_module_item_utils.dart';

class AnimatedColorWrapper extends StatefulWidget {
  final Color contentColor;
  final RiverModuleItemState state;
  final RiverModuleItemType iconType;

  const AnimatedColorWrapper({
    super.key,
    required this.contentColor,
    required this.state,
    required this.iconType,
  });

  @override
  AnimatedColorWrapperState createState() => AnimatedColorWrapperState();
}

class AnimatedColorWrapperState extends State<AnimatedColorWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _colorTween = ColorTween(begin: widget.state.getBackgroundColor(widget.contentColor), end: widget.contentColor).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) => const SizedBox.shrink(),
    );
  }
}
