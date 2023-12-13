import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

typedef OnPressed = void Function();

class CustomOutlinedButton extends StatelessWidget {
  final OnPressed onPressed;
  final Color? color;
  final ButtonStyle? styles;
  final String label;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color,
    this.styles,
  });

  factory CustomOutlinedButton.coralFullWidth({required OnPressed onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          side: ButtonStyles.borderCoral,
        ),
      );

  factory CustomOutlinedButton.coral({required OnPressed onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          side: ButtonStyles.borderCoral,
        ),
      );

  factory CustomOutlinedButton.coralSmall({required OnPressed onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.smallSize,
          side: ButtonStyles.borderCoral,
        ),
      );

  factory CustomOutlinedButton.orangeFullWidth(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          side: ButtonStyles.borderOrange,
        ),
      );

  factory CustomOutlinedButton.orange(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          side: ButtonStyles.borderOrange,
        ),
      );
  factory CustomOutlinedButton.orangeSmall(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.smallSize,
          side: ButtonStyles.borderOrange,
        ),
      );

  factory CustomOutlinedButton.yellowFullWidth(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          side: ButtonStyles.borderYellow,
        ),
      );

  factory CustomOutlinedButton.yellow(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ElevatedButton.styleFrom(
          side: ButtonStyles.borderYellow,
        ),
      );

  factory CustomOutlinedButton.yellowSmall(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.smallSize,
          side: ButtonStyles.borderYellow,
        ),
      );

  factory CustomOutlinedButton.greenFullWidth(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          side: ButtonStyles.borderGreen,
        ),
      );

  factory CustomOutlinedButton.green(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          side: ButtonStyles.borderGreen,
        ),
      );

  factory CustomOutlinedButton.greenSmall(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.smallSize,
          side: ButtonStyles.borderGreen,
        ),
      );

  factory CustomOutlinedButton.petrolFullWidth(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          side: ButtonStyles.borderPetrol,
        ),
      );

  factory CustomOutlinedButton.petrol(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          side: ButtonStyles.borderPetrol,
        ),
      );

  factory CustomOutlinedButton.petrolSmall(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.smallSize,
          side: ButtonStyles.borderPetrol,
        ),
      );

  factory CustomOutlinedButton.blueFullWidth(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          side: ButtonStyles.borderBlue,
        ),
      );

  factory CustomOutlinedButton.blue(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          side: ButtonStyles.borderBlue,
        ),
      );

  factory CustomOutlinedButton.blueSmall(
          {required OnPressed onPressed, required String label, bool fullWidth = false}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.smallSize,
          side: ButtonStyles.borderBlue,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: styles,
      child: Text(label).tr(),
    );
  }
}
