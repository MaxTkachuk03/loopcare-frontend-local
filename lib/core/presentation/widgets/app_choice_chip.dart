import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AppChoiceChip<T> extends StatelessWidget {
  final String label;
  final bool selected;
  final T value;
  final void Function(T value) onSelected;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;
  final double? labelWidth;
  final double? chipHeight;
  final bool available;

  const AppChoiceChip({
    Key? key,
    required this.label,
    required this.selected,
    required this.value,
    required this.onSelected,
    this.textAlign,
    this.padding,
    this.labelWidth,
    this.chipHeight,
    this.available = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final choiceChip = ChoiceChip(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 30.0),
      label: SizedBox(
        width: labelWidth ?? double.infinity,
        height: 22.0,
        child: AutoSizeText(
          label,
          textAlign: textAlign ?? TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: available
                ? selected
                ? AppColors.white
                : AppColors.darkGreen
                : AppColors.greyMid,
          ),
        ),
      ),
      labelPadding: const EdgeInsets.symmetric(vertical: 8.0),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      side: BorderSide(
        width: 1.0,
        color: !selected ? AppColors.yellowLight : Colors.transparent,
      ),
    );

    if (chipHeight != null) {
      return SizedBox(
        height: chipHeight,
        child: choiceChip,
      );
    }

    return choiceChip;
  }
}
