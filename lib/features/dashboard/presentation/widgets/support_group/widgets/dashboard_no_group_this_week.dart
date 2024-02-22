import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class DashboardNoGroupThisWeek extends StatelessWidget {
  const DashboardNoGroupThisWeek({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText.bitter600(
              LocalizedTexts.comingUpThisWeek.tr(),
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: 18),
            CustomText.w400(
              LocalizedTexts.noOtherTimeslotsAvailable.tr(),
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
