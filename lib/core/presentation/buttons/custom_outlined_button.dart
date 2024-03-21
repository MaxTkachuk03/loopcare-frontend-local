import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final ButtonStyle? styles;
  final String label;

  const CustomOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.color,
    this.styles,
  });

  factory CustomOutlinedButton.coralFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderCoral),
        ),
      );

  factory CustomOutlinedButton.coral({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderCoral),
        ),
      );

  factory CustomOutlinedButton.coralSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderCoral),
        ),
      );

  factory CustomOutlinedButton.orangeFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderOrange),
        ),
      );

  factory CustomOutlinedButton.orange({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderOrange),
        ),
      );

  factory CustomOutlinedButton.orangeSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderOrange),
        ),
      );

  factory CustomOutlinedButton.yellowFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
        ),
      );

  factory CustomOutlinedButton.yellow({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    ButtonStyle? style,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: style ??
            ButtonStyle(
              side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
            ),
      );

  factory CustomOutlinedButton.yellowSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
        ),
      );

  factory CustomOutlinedButton.greenFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderGreen),
        ),
      );

  factory CustomOutlinedButton.green({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderGreen),
        ),
      );

  factory CustomOutlinedButton.greenSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderGreen),
        ),
      );

  factory CustomOutlinedButton.petrolFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderPetrol),
        ),
      );

  factory CustomOutlinedButton.petrol({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderPetrol),
        ),
      );

  factory CustomOutlinedButton.petrolSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderPetrol),
        ),
      );

  factory CustomOutlinedButton.blueFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderBlue),
        ),
      );

  factory CustomOutlinedButton.blue({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderBlue),
        ),
      );

  factory CustomOutlinedButton.blueSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomOutlinedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderBlue),
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
