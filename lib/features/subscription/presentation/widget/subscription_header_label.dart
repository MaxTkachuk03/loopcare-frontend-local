import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SubscriptionHeaderLabel extends StatelessWidget {
  final String label;
  final String? subTitle;
  final Color? color;

  const SubscriptionHeaderLabel({
    super.key,
    required this.label,
    this.subTitle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          if (subTitle != null)
            CustomText(
              subTitle!.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: color ?? AppColors.blueDarker,
                fontWeight: FontWeight.w600,
              ),
            ),
          SizedBox(height: subTitle != null ? 11 : 16.0),
          CustomText(
            label.tr(),
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: color ?? AppColors.blueDarker,
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
