import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/circle_plus_button/circle_plus_button.dart';

class NutritionIntakeButton extends StatelessWidget {
  const NutritionIntakeButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.greenDarker,
                offset: Offset(0, 9),
                blurRadius: 25.0,
                spreadRadius: -10,
              ),
            ],
          ),
          child: CirclePlusButton(
            color: AppColors.greenLightest,
            onPressed: onPressed,
            width: 0,
          ),
        ),
        const SizedBox(height: 5.0),
        CustomText.w700(
          text,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.greyLight),
        ),
      ],
    );
  }
}
