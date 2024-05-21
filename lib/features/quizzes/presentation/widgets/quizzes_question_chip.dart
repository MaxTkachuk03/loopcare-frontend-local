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
  });q

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
    if (correct == null) return AppColors.blueRegular;

    if (correct!) return AppColors.greenRegular;

    if (!correct!) return AppColors.red;
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        side: BorderSide(width: 2, color: _getBorderColor()),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(26.0)),
        ),
        alignment: Alignment.centerLeft
      ),
      onPressed: () => onSelected(label),
      icon: correct != null ? _icon(correct ?? false) : const SizedBox.shrink(),
      label: CustomText.w400(
        label,
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}
