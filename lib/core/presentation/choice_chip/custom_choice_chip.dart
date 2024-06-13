import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text_with_accents/text_with_accents.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

typedef OnSelected<T> = void Function(T val);

class CustomChoiceChip<T> extends StatelessWidget {
  final String? label;
  final TextWithAccents? accent;
  final bool selected;
  final T value;
  final void Function(T val)? onSelected;
  final Color? selectedColor;
  final Color? borderColor;
  final Widget? avatar;
  final Widget? action;
  final bool? showCheckmark;
  final double? labelWidth;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;
  final double? chipHeight;
  final double? borderRadius;

  const CustomChoiceChip({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.value,
    this.label,
    this.accent,
    this.selectedColor,
    this.borderColor,
    this.avatar,
    this.showCheckmark,
    this.action,
    this.labelWidth,
    this.padding,
    this.textAlign,
    this.chipHeight,
    this.borderRadius,
  }) : assert(
          (label == null && accent != null) || (label != null && accent == null),
        );

  factory CustomChoiceChip.coral({
    required bool selected,
    required OnSelected<T>? onSelected,
    required T value,
    required String label,
    Widget? action,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.coralRegular,
        borderColor: AppColors.coralRegular,
        action: action,
      );

  factory CustomChoiceChip.orange({
    required bool selected,
    required OnSelected<T>? onSelected,
    required T value,
    required String label,
    Widget? avatar,
    bool? available,
    final EdgeInsetsGeometry? padding,
    final TextAlign? textAlign,
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
        padding: padding,
        textAlign: textAlign,
      );

  factory CustomChoiceChip.emoji({
    required String label,
    Widget? avatar,
    required bool selected,
    required T value,
    required OnSelected<T>? onSelected,
    Color? color = AppColors.yellowRegular,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: color,
        borderColor: color,
        avatar: avatar,
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        chipHeight: 57.0,
        borderRadius: 30.0,
      );

  factory CustomChoiceChip.yellow({
    required bool selected,
    required OnSelected<T>? onSelected,
    required T value,
    required String label,
    final EdgeInsetsGeometry? padding,
    final TextAlign? textAlign,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.yellowRegular,
        borderColor: AppColors.yellowRegular,
        padding: padding,
        textAlign: textAlign,
      );

  factory CustomChoiceChip.green({
    required bool selected,
    required OnSelected<T>? onSelected,
    required T value,
    String? label,
    Widget? action,
    TextWithAccents? accent,
  }) =>
      CustomChoiceChip<T>(
        label: label,
        accent: accent,
        selected: selected,
        onSelected: onSelected,
        value: value,
        selectedColor: AppColors.greenRegular,
        borderColor: AppColors.greenRegular,
        action: action,
      );

  factory CustomChoiceChip.petrol({
    required bool selected,
    required OnSelected<T>? onSelected,
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
    required OnSelected<T>? onSelected,
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
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 25.0, vertical: 14.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 25))),
        label: SizedBox(
          height: chipHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: accent != null
                    ? accent!
                    : AutoSizeText(
                        label ?? '',
                        textAlign: textAlign ?? TextAlign.start,
                        style: selected
                            ? context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)
                            : context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
                      ),
              ),
              if (action != null) action!,
            ],
          ),
        ),
        selected: selected,
        onSelected: onSelected == null ? null : (_) => onSelected?.call(value),
        selectedColor: selectedColor,
        disabledColor: AppColors.greyLight,
        side: ChipTheme.of(context).side?.copyWith(color: onSelected == null ? AppColors.greyLight : borderColor),
        color: WidgetStateProperty.resolveWith((states) {
          const Set<WidgetState> interactiveStates = <WidgetState>{
            WidgetState.pressed,
            WidgetState.selected,
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
