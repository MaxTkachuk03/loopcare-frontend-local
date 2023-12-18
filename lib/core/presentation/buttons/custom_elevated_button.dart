import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

typedef OnPressed = void Function();

class CustomElevatedButton extends StatelessWidget {
  final OnPressed? onPressed;
  final Color? color;
  final ButtonStyle? styles;
  final String label;

  const CustomElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.color,
    this.styles,
  });

  factory CustomElevatedButton.coralFullWidth({OnPressed? onPressed, required String label}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coralRegular,
          minimumSize: ButtonStyles.fullWidthSize,
          foregroundColor: AppColors.blueDarker,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.coral({OnPressed? onPressed, required String label}) => CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coralRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.coralSmall({OnPressed? onPressed, required String label}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coralRegular,
          minimumSize: ButtonStyles.smallSize,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.orangeFullWidth(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          backgroundColor: AppColors.orangeRegular,
          foregroundColor: AppColors.blueDarker,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.orange(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orangeRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.orangeSmall(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orangeRegular,
          foregroundColor: AppColors.blueDarker,
          minimumSize: ButtonStyles.smallSize,
        ),
      );

  factory CustomElevatedButton.yellowFullWidth(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellowRegular,
          minimumSize: ButtonStyles.fullWidthSize,
          foregroundColor: AppColors.blueDarker,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.yellow(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellowRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.yellowSmall(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellowRegular,
          foregroundColor: AppColors.blueDarker,
          minimumSize: ButtonStyles.smallSize,
        ),
      );
  factory CustomElevatedButton.greenFullWidth(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          backgroundColor: AppColors.greenRegular,
          foregroundColor: AppColors.blueDarker,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.green({OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.greenSmall(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenRegular,
          foregroundColor: AppColors.blueDarker,
          minimumSize: ButtonStyles.smallSize,
        ),
      );

  factory CustomElevatedButton.petrolFullWidth(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          backgroundColor: AppColors.petrolRegular,
          foregroundColor: AppColors.white,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.petrol(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.petrolRegular,
          foregroundColor: AppColors.white,
        ),
      );

  factory CustomElevatedButton.petrolSmall(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.petrolRegular,
          foregroundColor: AppColors.white,
          minimumSize: ButtonStyles.smallSize,
        ),
      );

  factory CustomElevatedButton.blueFullWidth(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueRegular,
          minimumSize: ButtonStyles.fullWidthSize,
          foregroundColor: AppColors.white,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.blue({OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueRegular,
          foregroundColor: AppColors.white,
        ),
      );

  factory CustomElevatedButton.blueSmall(
          {OnPressed? onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueRegular,
          foregroundColor: AppColors.white,
          minimumSize: ButtonStyles.smallSize,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: styles,
      child: Text(label).tr(),
    );
  }
}
