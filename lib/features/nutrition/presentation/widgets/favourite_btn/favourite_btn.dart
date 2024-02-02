import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class FavouriteBtn extends StatefulWidget {
  final void Function() onPress;
  final bool isActive;

  const FavouriteBtn({
    super.key,
    required this.onPress,
    required this.isActive,
  });

  @override
  State<FavouriteBtn> createState() => _FavouriteBtnState();
}

class _FavouriteBtnState extends State<FavouriteBtn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween<double>(begin: 1, end: 0.5).animate(_controller);
  }

  @override
  void didUpdateWidget(FavouriteBtn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      _controller.forward().then((value) => _controller.reverse());
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
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.greenLighter,
        child: CustomIconButton(
          icon: Icon(
            widget.isActive ? Icons.star_rounded : Icons.star_outline_rounded,
            size: 28,
            color: AppColors.blueDarker,
          ),
          onPressed: widget.onPress,
        ),
      ),
    );
  }
}
