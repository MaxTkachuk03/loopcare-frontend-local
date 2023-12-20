import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

typedef OnSelected<T> = void Function(T val);

class CustomChoiceChip<T> extends StatelessWidget {
  final String label;
  final bool selected;
  final T value;
  final void Function(T val) onSelected;
  final Color? selectedColor;
  final Color? borderColor;

  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    required this.value,
    this.selectedColor,
    this.borderColor,
  });

  factory CustomChoiceChip.coral({
    required bool selected,
    required OnSelected<T> onSelected,
    required T value,
    required String label,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.coralRegular,
        borderColor: AppColors.coralRegular,
      );

  factory CustomChoiceChip.orange({
    required bool selected,
    required OnSelected<T> onSelected,
    required T value,
    required String label,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.orangeRegular,
        borderColor: AppColors.orangeRegular,
      );

  factory CustomChoiceChip.yellow({
    required bool selected,
    required OnSelected<T> onSelected,
    required T value,
    required String label,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.yellowRegular,
        borderColor: AppColors.yellowRegular,
      );

  factory CustomChoiceChip.green({
    required bool selected,
    required OnSelected<T> onSelected,
    required T value,
    required String label,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.greenRegular,
        borderColor: AppColors.greenRegular,
      );

  factory CustomChoiceChip.petrol({
    required bool selected,
    required OnSelected<T> onSelected,
    required T value,
    required String label,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.petrolRegular,
        borderColor: AppColors.petrolRegular,
      );

  factory CustomChoiceChip.blue({
    required bool selected,
    required OnSelected<T> onSelected,
    required T value,
    required String label,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.blueRegular,
        borderColor: AppColors.blueRegular,
      );

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: SizedBox(width: double.infinity, child: Text(label).tr()),
      selected: selected,
      onSelected: (_) => onSelected(value),
      selectedColor: selectedColor,
      side: ChipTheme.of(context).side?.copyWith(color: borderColor),
    );
  }
}
