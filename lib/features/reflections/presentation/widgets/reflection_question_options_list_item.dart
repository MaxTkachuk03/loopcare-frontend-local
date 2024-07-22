import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_question_option.dart';

class ReflectionQuestionOptionsListItem extends StatelessWidget {
  final ReflectionQuestionOption item;
  final bool selected;
  final void Function(int value) onSelected;

  const ReflectionQuestionOptionsListItem({
    super.key,
    required this.item,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(item.id),
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: selected ? AppColors.greenRegular : AppColors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          border: Border.all(
            width: 2,
            color: selected ? AppColors.greenRegular : AppColors.blueRegular,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText.w400(item.label, style: context.textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
