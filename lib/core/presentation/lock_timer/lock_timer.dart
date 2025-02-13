import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class LockTimer extends StatelessWidget {
  const LockTimer({super.key, required this.features, required this.days});

  final String features;
  final int days;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcons.circularLock,
            const SizedBox(height: 8.0),
            const Dash(
                direction: Axis.horizontal,
                length: 345.0,
                dashLength: 8.0,
                dashColor: AppColors.greyDarker),
            const SizedBox(height: 8.0),
            CustomText.w400(
                LocalizedTexts.lockTimer
                    .tr({"features": features, "days": '$days'}),
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: AppColors.greyDarker, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
