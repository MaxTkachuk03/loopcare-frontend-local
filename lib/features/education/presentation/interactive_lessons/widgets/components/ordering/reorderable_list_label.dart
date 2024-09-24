import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class ReorderableListLabel extends StatelessWidget {
  final String label;
  const ReorderableListLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: CustomText.w700(
        label,
        style: context.textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
