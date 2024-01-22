import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

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
          color: isFilled ? AppColors.greenRegular : AppColors.greyLight,
        ),
        CustomText.w400(
          label,
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}
