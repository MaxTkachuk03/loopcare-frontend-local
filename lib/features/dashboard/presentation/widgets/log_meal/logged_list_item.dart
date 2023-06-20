import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class LoggedListItem extends StatelessWidget {
  final String label;
  final bool isFilled;

  const LoggedListItem({
    super.key,
    required this.label,
    required this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageIcon(
          AppIcons.checkmark,
          color: isFilled ? AppColors.blueMid : AppColors.greyMid,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: ThemeConstants.fontSize12,
                color: isFilled ? AppColors.darkGreen : AppColors.greyLabel,
              ),
        ),
      ],
    );
  }
}
