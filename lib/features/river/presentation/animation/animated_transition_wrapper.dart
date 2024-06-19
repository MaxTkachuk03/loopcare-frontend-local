import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AnimatedTransitionWrapper extends StatefulWidget {
  final Widget child;
  final double sizeBadge;

  const AnimatedTransitionWrapper({super.key, required this.child, this.sizeBadge = 15});

  @override
  State<AnimatedTransitionWrapper> createState() => _AnimatedTransitionWrapperState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _AnimatedTransitionWrapperState extends State<AnimatedTransitionWrapper>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        //   AnimatedPositioned(
        //   width:  200.0 ,
        //   height: 200.0,
        //   top:  150.0,
        //   duration: const Duration(seconds: 2),
        //   curve: Curves.fastOutSlowIn,
        //   child: widget.child,
        // );

        AlignTransition(
      alignment: _animation,
      child: badge.Badge(
        badgeStyle: const badge.BadgeStyle(
          padding: EdgeInsets.all(5),
          badgeColor: AppColors.blueRegular,
          elevation: 0,
        ),
        badgeAnimation: const badge.BadgeAnimation.slide(toAnimate: false),
        position: badge.BadgePosition.topEnd(top: -8, end: -4),
        badgeContent: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Icon(
            Icons.check,
            color: AppColors.white,
            size: widget.sizeBadge,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
