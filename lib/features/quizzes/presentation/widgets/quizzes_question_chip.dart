import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class QuizzesQuestionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final void Function(String value) onSelected;
  final bool? correct;
  final bool? active;
  final bool? quiz;

  const QuizzesQuestionChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.correct,
    this.active,
    this.quiz,
  });

  Widget _icon(bool correct) {
    return correct
        ? const CircleAvatar(
            radius: 13,
            backgroundColor: AppColors.greenRegular,
            child: Icon(Icons.check, color: AppColors.white, size: 16),
          )
        : const CircleAvatar(
            radius: 13,
            backgroundColor: AppColors.red,
            child: Icon(Icons.close, color: AppColors.white, size: 16),
          );
  }

  _getBorderColor() {
    final c = correct;

    if (c == null) return AppColors.blueRegular;

    if (c) return AppColors.greenRegular;

    if (!c) return AppColors.red;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          border: Border.all(width: 2, color: _getBorderColor()),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (correct != null)
              Padding(padding: const EdgeInsets.only(right: 8.0), child: _icon(correct ?? false)),
            Expanded(child: CustomText.w400(label, style: context.textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }
}
