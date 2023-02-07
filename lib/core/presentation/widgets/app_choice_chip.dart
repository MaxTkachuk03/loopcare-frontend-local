import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AppChoiceChip<T> extends StatelessWidget {
  final String label;
  final bool selected;
  final T value;
  final void Function(T value) onSelected;
  final TextAlign? textAlign;

  const AppChoiceChip({
    Key? key,
    required this.label,
    required this.selected,
    required this.value,
    required this.onSelected,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      label: SizedBox(
        width: double.infinity,
        child: Text(
          label,
          textAlign: textAlign ?? TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.white : AppColors.darkGreen,
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
      backgroundColor: AppColors.white,
      labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: selected ? AppColors.white : AppColors.darkGreen,
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
  }
}
