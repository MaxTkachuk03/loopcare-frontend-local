import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class NoTimeslots extends StatelessWidget {
  const NoTimeslots({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.w400(
          LocalizedTexts.comingUpThisWeek.tr().toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: ThemeConstants.fontSize12),
        ),
        const SizedBox(height: 16.0),
        CustomText.w600(
          LocalizedTexts.noOtherTimeslotsAvailable.tr(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
