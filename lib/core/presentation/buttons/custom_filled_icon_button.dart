import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomFilledIconButton extends StatelessWidget {
  final Widget icon;
  final void Function() onPressed;
  final Color? color;
  final ButtonStyle? styles;
  final double? iconSize;

  const CustomFilledIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.styles,
    this.iconSize = 28,
  });

  factory CustomFilledIconButton.leadingCoralLighter({required void Function() onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.coralLighter),
      );

  factory CustomFilledIconButton.leadingOrangeLighter({required void Function() onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.orangeLighter),
      );

  factory CustomFilledIconButton.leadingYellowLighter({required void Function() onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.yellowLighter),
      );

  factory CustomFilledIconButton.leadingGreenLighter({required void Function() onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.greenLighter),
      );

  factory CustomFilledIconButton.leadingPetrolLighter({required void Function() onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.petrolLighter),
      );

  factory CustomFilledIconButton.leadingBlueLighter({required void Function() onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.blueLighter),
      );

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      alignment: Alignment.center,
      onPressed: onPressed,
      icon: icon,
      iconSize: iconSize,
      color: color,
      style: styles,
    );
  }
}
