import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomFilledIconButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;
  final Color? color;
  final ButtonStyle? styles;
  final double? iconSize;

  const CustomFilledIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.styles,
    this.iconSize = 28,
  });

  factory CustomFilledIconButton.fromColor({
    Key? key,
    required Color color,
    void Function()? onPressed,
  }) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: color),
      );

  factory CustomFilledIconButton.leadingCoralLighter({void Function()? onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.coralLighter),
      );

  factory CustomFilledIconButton.leadingOrangeLighter({void Function()? onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.orangeLighter),
      );

  factory CustomFilledIconButton.leadingYellowLighter({void Function()? onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.yellowLighter),
      );

  factory CustomFilledIconButton.leadingGreenLighter({void Function()? onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.greenLighter),
      );

  factory CustomFilledIconButton.leadingPetrolLighter({void Function()? onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.petrolLighter),
      );

  factory CustomFilledIconButton.leadingBlueLighter({void Function()? onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.blueLighter),
      );

  factory CustomFilledIconButton.leadingWhite({void Function()? onPressed}) =>
      CustomFilledIconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: onPressed,
        color: AppColors.blueDarker,
        styles: IconButton.styleFrom(backgroundColor: AppColors.white),
      );

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      alignment: Alignment.center,
      onPressed: onPressed ?? context.router.maybePop,
      icon: icon,
      iconSize: iconSize,
      color: color,
      style: styles,
    );
  }
}
