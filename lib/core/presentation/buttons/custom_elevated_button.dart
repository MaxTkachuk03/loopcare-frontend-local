import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
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

  factory CustomElevatedButton.coralFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coralRegular,
          minimumSize: ButtonStyles.fullWidthSize,
          foregroundColor: AppColors.blueDarker,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.coral({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coralRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.coralSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coralRegular,
          minimumSize: ButtonStyles.smallSize,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.orangeFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          backgroundColor: AppColors.orangeRegular,
          foregroundColor: AppColors.blueDarker,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.orange({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orangeRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.orangeSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orangeRegular,
          foregroundColor: AppColors.blueDarker,
          minimumSize: ButtonStyles.smallSize,
        ),
      );

  factory CustomElevatedButton.yellowFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
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

  factory CustomElevatedButton.yellow({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellowRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.yellowSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    EdgeInsetsGeometry? contentPadding,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        color: AppColors.blueDarker,
        label: label,
        styles: ElevatedButton.styleFrom(
          padding: contentPadding,
          backgroundColor: AppColors.yellowRegular,
          foregroundColor: AppColors.blueDarker,
          minimumSize: ButtonStyles.smallSize,
        ),
      );

  factory CustomElevatedButton.greenFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          backgroundColor: AppColors.greenRegular,
          foregroundColor: AppColors.blueDarker,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.green({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenRegular,
          foregroundColor: AppColors.blueDarker,
        ),
      );

  factory CustomElevatedButton.greenSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenRegular,
          foregroundColor: AppColors.blueDarker,
          minimumSize: ButtonStyles.smallSize,
        ),
      );

  factory CustomElevatedButton.petrolFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          minimumSize: ButtonStyles.fullWidthSize,
          backgroundColor: AppColors.petrolRegular,
          foregroundColor: AppColors.white,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.petrol({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.petrolRegular,
          foregroundColor: AppColors.white,
        ),
      );

  factory CustomElevatedButton.petrolSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.petrolRegular,
          foregroundColor: AppColors.white,
          minimumSize: ButtonStyles.smallSize,
        ),
      );

  factory CustomElevatedButton.blueFullWidth({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueRegular,
          minimumSize: ButtonStyles.fullWidthSize,
          foregroundColor: AppColors.white,
          textStyle: ButtonStyles.fullWidthLabel,
        ),
      );

  factory CustomElevatedButton.blue({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
        onPressed: onPressed,
        label: label,
        styles: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueRegular,
          foregroundColor: AppColors.white,
        ),
      );

  factory CustomElevatedButton.blueSmall({
    Key? key,
    VoidCallback? onPressed,
    required String label,
    bool fullWidth = false,
  }) =>
      CustomElevatedButton(
        key: key,
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
      child: Text(label),
    );
  }
}
