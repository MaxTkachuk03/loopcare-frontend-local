import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class GroupedNoTimeslots extends StatelessWidget {
  const GroupedNoTimeslots({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      LocalizedTexts.noOtherTimeslotsAvailable.tr(),
      style: const TextStyle(
        fontSize: ThemeConstants.fontSize12,
        color: AppColors.darkGreen,
      ),
    );
  }
}
