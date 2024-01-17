import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

typedef OnPressed = void Function();

class CustomOutlinedButton extends StatelessWidget {
  final OnPressed? onPressed;
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

  factory CustomOutlinedButton.coralFullWidth({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderCoral),
        ),
      );

  factory CustomOutlinedButton.coral({OnPressed? onPressed, required String label}) => CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderCoral),
        ),
      );

  factory CustomOutlinedButton.coralSmall({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderCoral),
        ),
      );

  factory CustomOutlinedButton.orangeFullWidth({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderOrange),
        ),
      );

  factory CustomOutlinedButton.orange({OnPressed? onPressed, required String label}) => CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderOrange),
        ),
      );

  factory CustomOutlinedButton.orangeSmall({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderOrange),
        ),
      );

  factory CustomOutlinedButton.yellowFullWidth({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
        ),
      );

  factory CustomOutlinedButton.yellow({OnPressed? onPressed, required String label}) => CustomOutlinedButton(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
        ),
      );

  factory CustomOutlinedButton.yellowSmall({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
        ),
      );

  factory CustomOutlinedButton.greenFullWidth({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderGreen),
        ),
      );

  factory CustomOutlinedButton.green({OnPressed? onPressed, required String label}) => CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderGreen),
        ),
      );

  factory CustomOutlinedButton.greenSmall({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderGreen),
        ),
      );

  factory CustomOutlinedButton.petrolFullWidth({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderPetrol),
        ),
      );

  factory CustomOutlinedButton.petrol({OnPressed? onPressed, required String label}) => CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderPetrol),
        ),
      );

  factory CustomOutlinedButton.petrolSmall({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderPetrol),
        ),
      );

  factory CustomOutlinedButton.blueFullWidth({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          minimumSize: MaterialStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderBlue),
        ),
      );

  factory CustomOutlinedButton.blue({OnPressed? onPressed, required String label}) => CustomOutlinedButton(
        onPressed: onPressed,
        label: label,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderBlue),
        ),
      );

  factory CustomOutlinedButton.blueSmall({OnPressed? onPressed, required String label}) =>
      CustomOutlinedButton(
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
