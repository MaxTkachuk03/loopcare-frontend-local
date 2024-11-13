import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class MoodPickerSelectedCell extends StatelessWidget {
  final Widget child;

  const MoodPickerSelectedCell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.orangeOffRegular,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: child,
    );
  }
}
