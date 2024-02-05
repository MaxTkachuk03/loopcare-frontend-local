import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

const _kSelectedHeight = 66.0;

class SelectedCell extends StatelessWidget {
  final int index;
  final String? label;
  final Color selectedColor;

  const SelectedCell({
    super.key,
    required this.index,
    required this.selectedColor,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kSelectedHeight,
      decoration: BoxDecoration(
        color: selectedColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
