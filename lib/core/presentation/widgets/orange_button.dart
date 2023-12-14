import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class OrangeButton extends StatelessWidget {
  final void Function()? onPressedHandler;
  final Widget child;

  const OrangeButton({super.key, required this.onPressedHandler, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedHandler,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.disabled) ? AppColors.greyMid : AppColors.orangeDark,
            ),
          ),
      child: child,
    );
  }
}
