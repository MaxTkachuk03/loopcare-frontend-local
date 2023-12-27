import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class PasswordStrengthIndicator extends StatefulWidget {
  final double strength;

  const PasswordStrengthIndicator({
    super.key,
    required this.strength,
  });

  @override
  State<PasswordStrengthIndicator> createState() => _PasswordStrengthState();
}

class _PasswordStrengthState extends State<PasswordStrengthIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: widget.strength <= 0 ? AppColors.greyMid : AppColors.red,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              border: Border.all(
                width: 3,
                color: widget.strength <= 0 ? AppColors.greyMid : AppColors.red,
                style: BorderStyle.solid,
              ),
            ),
            height: 8,
            margin: const EdgeInsets.only(right: 1),
          ),
        ),
        Expanded(
          child: Container(
            height: 8,
            color: widget.strength < 1 / 2 ? AppColors.greyMid : AppColors.orangeDark,
            margin: const EdgeInsets.only(right: 2),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: widget.strength > 1 / 2 ? AppColors.greenLight : AppColors.greyMid,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(
                width: 3,
                color: widget.strength > 1 / 2 ? AppColors.greenLight : AppColors.greyMid,
                style: BorderStyle.solid,
              ),
            ),
            height: 8,
          ),
        ),
      ],
    );
  }
}
