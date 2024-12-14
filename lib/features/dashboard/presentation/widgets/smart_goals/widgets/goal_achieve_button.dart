import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/animations/lottie_animation.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';

const achieveRadius = 22.0;
const duration = Duration(seconds: 2);

class GoalAchieveButton extends StatefulWidget {
  final WeeklySmartGoal item;
  final VoidCallback? onPressed;

  const GoalAchieveButton({super.key, required this.item, this.onPressed});

  @override
  State<GoalAchieveButton> createState() => _GoalAchieveButtonState();
}

class _GoalAchieveButtonState extends State<GoalAchieveButton> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  Color get bgColor => widget.item.isAchieved ? AppColors.greenRegular : AppColors.blueLightest;

  Color get fgColor => widget.item.isAchieved ? AppColors.white : AppColors.blueDarkest;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller?.dispose();
      _controller = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: bgColor.withOpacity(0.5),
      hoverColor: fgColor.withOpacity(0.5),
      onTap: widget.onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.item.isAchieved)
            LottieAnimation.achieved(
              controller: _controller,
              onLoaded: (composition) {
                _controller?.repeat();
              },
            )
          else
            LottieAnimation.noAchieved(
              controller: _controller,
              onLoaded: (composition) {
                _controller?.repeat();
              },
            ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              fgColor,
              BlendMode.srcIn,
            ),
            child: AppIcons.achieve,
          ),
        ],
      ),
    );
  }
}
