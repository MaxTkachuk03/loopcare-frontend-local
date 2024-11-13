import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/widgets/bottom_bar.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class BottomPlacedButton extends StatelessWidget {
  const BottomPlacedButton({
    super.key,
    required this.body,
    required this.button,
    this.backgroundColor = Colors.white,
    this.enableButton = true,
    this.buttonPadding,
  });

  final Color backgroundColor;
  final Widget button;
  final Widget body;
  final bool enableButton;
  final EdgeInsetsGeometry? buttonPadding;

  const BottomPlacedButton.yellowLightest({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.yellowLightest;

  const BottomPlacedButton.yellow({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.yellowOffRegular;

  const BottomPlacedButton.yellowDarker({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.yellowRegular;

  const BottomPlacedButton.blueLightest({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.blueLightest;

  const BottomPlacedButton.blue({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.blueOffRegular;

  const BottomPlacedButton.blueDarker({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.blueRegular;

  const BottomPlacedButton.orangeLightest({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.orangeLightest;

  const BottomPlacedButton.orange({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.orangeOffRegular;

  const BottomPlacedButton.orangeDarker({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.orangeRegular;

  const BottomPlacedButton.coralLightest({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.coralLightest;

  const BottomPlacedButton.coral({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.coralOffRegular;

  const BottomPlacedButton.coralDarker({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.coralRegular;

  const BottomPlacedButton.green({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.greenOffRegular;

  const BottomPlacedButton.greenLightest({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.greenLightest;

  const BottomPlacedButton.petrolLightest({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.petrolLightest;

  const BottomPlacedButton.petrol({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.petrolOffRegular;

  const BottomPlacedButton.petrolDarker({
    super.key,
    required this.body,
    required this.button,
    this.enableButton = true,
    this.buttonPadding,
  }) : backgroundColor = AppColors.petrolRegular;

  @override
  Widget build(BuildContext context) {
    Widget? bottomNavigationBar;
    if (enableButton) {
      bottomNavigationBar = BottomBar(
        backgroundColor: backgroundColor,
        contentPadding: buttonPadding,
        child: button,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.transparent,
      resizeToAvoidBottomInset: true,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
