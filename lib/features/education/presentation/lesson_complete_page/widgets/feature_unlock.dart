import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class FeatureUnlock extends StatelessWidget {
  final String title;
  final String body;
  final Widget? action;

  const FeatureUnlock({super.key, required this.title, required this.body, this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: const BoxDecoration(
        color: AppColors.petrolLightest,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIcons.lock,
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.w700(title, style: context.textTheme.bodyMedium),
                const SizedBox(height: 4.0),
                CustomText.w400(body, style: context.textTheme.bodyMedium),
                const SizedBox(height: 16.0),
                if (action != null) action!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
