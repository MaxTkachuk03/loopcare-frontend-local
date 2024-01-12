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
  final Widget? avatar;
  final bool? showCheckmark;

  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    required this.value,
    this.selectedColor,
    this.borderColor,
    this.avatar,
    this.showCheckmark,
  });

  factory CustomChoiceChip.coral({
    required bool selected,
    required OnSelected<T> onSelected,
    required T value,
    required String label,
    Color? backgroundColor,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.coralRegular,
        borderColor: AppColors.coralRegular,
        backgroundColor: backgroundColor,
      );

  factory CustomChoiceChip.orange({
    required bool selected,
    required OnSelected<T> onSelected,
    required T value,
    required String label,
    Widget? avatar,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.orangeRegular,
        borderColor: AppColors.orangeRegular,
        avatar: avatar,
        showCheckmark: false,
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
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: AppColors.transparent),
      child: ChoiceChip(
        label: SizedBox(width: double.infinity, child: Text(label).tr()),
        selected: selected,
        onSelected: (_) => onSelected(value),
        selectedColor: selectedColor,
        side: ChipTheme.of(context).side?.copyWith(color: borderColor),
        color: MaterialStateProperty.resolveWith((states) {
          const Set<MaterialState> interactiveStates = <MaterialState>{
            MaterialState.pressed,
            MaterialState.selected,
          };

          if (states.any(interactiveStates.contains)) {
            return selectedColor;
          }

          return AppColors.transparent;
        }),
        avatar: avatar,
        showCheckmark: showCheckmark,
      ),
    );
  }
}
