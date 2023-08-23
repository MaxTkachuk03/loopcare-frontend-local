import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class NoTimeslots extends StatelessWidget {
  const NoTimeslots({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizedTexts.comingUpThisWeek.tr().toUpperCase(),
          style: const TextStyle(
            fontSize: ThemeConstants.fontSize12,
            color: AppColors.greyLabel,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          LocalizedTexts.noOtherTimeslotsAvailable,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ).tr(),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
