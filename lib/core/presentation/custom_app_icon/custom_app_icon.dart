import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons_data.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const double _iconSizeCoefficient = 1.64;
const double _itemSize = 22.0;

class CustomAppIcon extends StatelessWidget {
  const CustomAppIcon(
    this.icon, {
    super.key,
    this.radius = _itemSize,
    this.iconSize,
    required this.iconColor,
    required this.backgroundColor,
  });

  const CustomAppIcon.reflection({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iReflection,
        iconSize = radius * 1.44,
        iconColor = AppColors.petrolLightest,
        backgroundColor = AppColors.petrolRegular;

  const CustomAppIcon.reflectionGrey({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iReflection,
        iconSize = radius * 1.44,
        iconColor = AppColors.petrolLightest,
        backgroundColor = AppColors.greyLighter;

  const CustomAppIcon.mind({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iMind,
        iconSize = radius * _iconSizeCoefficient,
        iconColor = AppColors.petrolLightest,
        backgroundColor = AppColors.petrolRegular;

  const CustomAppIcon.physicalActivity({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iActivity,
        iconSize = radius * _iconSizeCoefficient,
        iconColor = AppColors.yellowLightest,
        backgroundColor = AppColors.yellowRegular;

  const CustomAppIcon.buddy({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iBuddy,
        iconSize = radius * _iconSizeCoefficient,
        iconColor = AppColors.orangeLightest,
        backgroundColor = AppColors.orangeRegular;

  const CustomAppIcon.community({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iCommunity,
        iconSize = radius * _iconSizeCoefficient,
        iconColor = AppColors.orangeLightest,
        backgroundColor = AppColors.orangeRegular;

  const CustomAppIcon.mood({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iMood,
        iconSize = radius * _iconSizeCoefficient,
        iconColor = AppColors.orangeLightest,
        backgroundColor = AppColors.orangeRegular;

  const CustomAppIcon.medical({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iMedical,
        iconSize = radius * _iconSizeCoefficient,
        iconColor = AppColors.coralLightest,
        backgroundColor = AppColors.coralRegular;

  const CustomAppIcon.weight({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iWeight,
        iconSize = radius * _iconSizeCoefficient,
        iconColor = AppColors.coralLightest,
        backgroundColor = AppColors.coralRegular;

  const CustomAppIcon.smartGoal({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iGoal,
        iconSize = radius * _iconSizeCoefficient,
        iconColor = AppColors.greenLightest,
        backgroundColor = AppColors.greenRegular;

  const CustomAppIcon.nutrition({super.key, this.radius = _itemSize})
      : icon = AppIconsData.iNutrition,
        iconSize = radius * _iconSizeCoefficient,
        iconColor = AppColors.greenLightest,
        backgroundColor = AppColors.greenRegular;

  final IconData icon;
  final double radius;
  final double? iconSize;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
