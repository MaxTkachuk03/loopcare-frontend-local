import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class WeeklyTimesCorrector extends StatelessWidget {
  final Function()? onIncrease;
  final Function()? onDecreased;

  const WeeklyTimesCorrector({super.key, required this.onIncrease, required this.onDecreased});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CircleButton(
          icon: Icons.add,
          onTap: onIncrease,
        ),
        const SizedBox(
          width: 8.0,
        ),
        _CircleButton(
          icon: Icons.remove,
          onTap: onDecreased,
        )
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: AppColors.blueLightest,
      child: IconButton(
        icon: Icon(
          icon,
          color: onTap == null ? AppColors.greyLight : AppColors.blueDarker,
        ),
        onPressed: onTap,
      ),
    );
  }
}
