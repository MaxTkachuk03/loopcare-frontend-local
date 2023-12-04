import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class QuizzesQuestionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final void Function(String value) onSelected;
  final Color? borderColor;
  final bool? correct;
  final bool? active;
  final bool? quiz;

  const QuizzesQuestionChip({
    Key? key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.borderColor,
    this.correct,
    this.active,
    this.quiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final choiceChip = InkWell(
      onTap: () => onSelected(label),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 22),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: active ?? true
                ? quiz ?? true
                    ? AppColors.white
                    : selected
                        ? AppColors.blueDark
                        : AppColors.white
                : AppColors.inactiveChipBg,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color:
                  !selected && (correct == null) ? borderColor ?? AppColors.yellowLight : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? quiz ?? true
                                ? AppColors.darkGreen
                                : AppColors.white
                            : AppColors.darkGreen,
                      ),
                ),
              ),
              if (correct != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _icon(correct ?? false),
                ),
            ],
          ),
        ),
      ),
    );

    return _stackWrapper(choiceChip);
  }

  Widget _icon(bool correct) {
    return correct
        ? const ImageIcon(
            AppIcons.checkmark,
            color: AppColors.correctGreen,
            size: 15,
          )
        : const Icon(
            Icons.close,
            color: AppColors.wrongRed,
            size: 15,
          );
  }

  Widget _stackWrapper(Widget child) {
    if (correct == null) return child;

    return IntrinsicHeight(
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          child,
          Container(
            width: 8.0,
            decoration: BoxDecoration(
              color: correct ?? false ? AppColors.correctGreen : AppColors.wrongRed,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
