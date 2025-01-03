import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SavingItem extends StatelessWidget {
  const SavingItem({
    super.key,
    required this.savings,
    required this.index,
    required this.isLimited,
  });

  final int savings;
  final int index;
  final bool isLimited;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: isLimited ? AppColors.limitedOffersavingColor : AppColors.savingColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: CustomText.w700('Save $savings%',
              style: context.textTheme.bodySmall?.copyWith(fontSize: 12, color: AppColors.white)),
        ),
      ],
    );
  }
}
