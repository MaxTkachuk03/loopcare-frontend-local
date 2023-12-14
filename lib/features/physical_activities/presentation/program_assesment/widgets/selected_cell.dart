import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SelectedCell extends StatelessWidget {
  final int index;
  final String? label;

  const SelectedCell({
    super.key,
    required this.index,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: AppColors.blueMid,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          label ?? '${index + 1}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
                fontSize: ThemeConstants.fontSize18,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
