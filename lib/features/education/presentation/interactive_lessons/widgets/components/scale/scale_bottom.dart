import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/scale_content/scale_content.dart';

class ScaleBottom extends StatelessWidget {
  const ScaleBottom({super.key, required this.content});

  final ScaleContent content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          content.lowestText,
          style: context.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        CustomText(
          content.highestText,
          style: context.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
