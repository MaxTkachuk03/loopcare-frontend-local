import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

typedef OnPressed = void Function();

class CustomOutlinedButtonWithIcon extends StatelessWidget {
  final String label;
  final Widget icon;
  final Color? color;
  final ButtonStyle? styles;
  final void Function()? onPressed;

  const CustomOutlinedButtonWithIcon(
      {super.key, required this.label, required this.icon, this.onPressed, this.color, this.styles});

  factory CustomOutlinedButtonWithIcon.coralFullWidth(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderCoral),
        ),
      );

  factory CustomOutlinedButtonWithIcon.coral(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderCoral),
        ),
      );

  factory CustomOutlinedButtonWithIcon.coralSmall(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderCoral),
        ),
      );

  factory CustomOutlinedButtonWithIcon.orangeFullWidth(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderOrange),
        ),
      );

  factory CustomOutlinedButtonWithIcon.orange(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderOrange),
        ),
      );
  factory CustomOutlinedButtonWithIcon.orangeSmall(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderOrange),
        ),
      );

  factory CustomOutlinedButtonWithIcon.yellowFullWidth(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
        ),
      );

  factory CustomOutlinedButtonWithIcon.yellow(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
        ),
      );

  factory CustomOutlinedButtonWithIcon.yellowSmall(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
        ),
      );

  factory CustomOutlinedButtonWithIcon.greenFullWidth(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderGreen),
        ),
      );

  factory CustomOutlinedButtonWithIcon.green(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderGreen),
        ),
      );

  factory CustomOutlinedButtonWithIcon.greenSmall(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderGreen),
        ),
      );

  factory CustomOutlinedButtonWithIcon.petrolFullWidth(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderPetrol),
        ),
      );

  factory CustomOutlinedButtonWithIcon.petrol(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderPetrol),
        ),
      );

  factory CustomOutlinedButtonWithIcon.petrolSmall(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderPetrol),
        ),
      );

  factory CustomOutlinedButtonWithIcon.blueFullWidth(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.fullWidthSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderBlue),
        ),
      );

  factory CustomOutlinedButtonWithIcon.blue({
    OnPressed? onPressed,
    required String label,
    required Widget icon,
    bool? needBackgroundColor,
  }) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderBlue),
          backgroundColor: WidgetStateProperty.all(
            needBackgroundColor ?? false ? AppColors.blueLightest : AppColors.transparent,
          ),
        ),
      );

  factory CustomOutlinedButtonWithIcon.blueSmall(
          {OnPressed? onPressed, required String label, required Widget icon}) =>
      CustomOutlinedButtonWithIcon(
        onPressed: onPressed,
        label: label,
        icon: icon,
        styles: ButtonStyle(
          minimumSize: WidgetStateProperty.all(ButtonStyles.smallSize),
          side: ButtonStyles.getButtonBorder(ButtonStyles.borderBlue),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      style: styles,
      label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
