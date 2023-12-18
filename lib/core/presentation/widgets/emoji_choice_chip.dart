import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class EmojiChoiceChip<T> extends StatelessWidget {
  final String label;
  final bool selected;
  final T value;
  final void Function(T value) onSelected;
  final bool available;
  final Widget icon;

  const EmojiChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.value,
    required this.onSelected,
    required this.icon,
    this.available = true,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 7.0),
            AutoSizeText(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: available
                        ? selected
                            ? AppColors.white
                            : AppColors.darkGreen
                        : AppColors.greyMid,
                  ),
            ),
          ],
        ),
      ),
      labelPadding: const EdgeInsets.symmetric(vertical: 9.0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      selected: selected,
      onSelected: (selected) => onSelected(value),
      selectedColor: AppColors.blueDark,
      shadowColor: Colors.transparent,
      elevation: 0,
      backgroundColor: available ? AppColors.white : AppColors.bgGreen,
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: available
                ? selected
                    ? AppColors.white
                    : AppColors.darkGreen
                : AppColors.greyMid,
          ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      side: const BorderSide(width: 1.0, color: AppColors.ff404040),
    );
  }
}
