import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SelectedCell extends StatelessWidget {
  final int index;
  final String? label;

  const SelectedCell({
    super.key,
    required this.index,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: const BoxDecoration(
        color: AppColors.greenRegular,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: CustomText.w700(
          label ?? '${index + 1}',
          style: context.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
