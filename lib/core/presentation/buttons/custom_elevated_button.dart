import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

typedef OnPressed = void Function();

class CustomElevatedButton extends StatelessWidget {
  final OnPressed onPressed;
  final Color? color;
  final ButtonStyle? styles;
  final String label;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color,
    this.styles,
  });

  factory CustomElevatedButton.coralFullWidth({required OnPressed onPressed, required String label}) =>
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

  factory CustomElevatedButton.coral({required OnPressed onPressed, required String label}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coralRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.coralSmall({required OnPressed onPressed, required String label}) =>
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
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orangeRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.orangeSmall(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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

  factory CustomElevatedButton.green(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.greenSmall(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.petrolRegular,
          foregroundColor: AppColors.white,
        ),
      );

  factory CustomElevatedButton.petrolSmall(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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

  factory CustomElevatedButton.blue(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomElevatedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueRegular,
          foregroundColor: AppColors.white,
        ),
      );

  factory CustomElevatedButton.blueSmall(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
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
