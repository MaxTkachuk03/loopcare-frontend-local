import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SelectedCell extends StatelessWidget {
  final int index;

  const SelectedCell({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.blueMid,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Center(
        child: Text(
          '$index',
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
