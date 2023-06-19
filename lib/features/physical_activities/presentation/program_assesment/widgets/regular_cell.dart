import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class RegularCell extends StatelessWidget {
  final int index;

  const RegularCell({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgGreen,
        border: _getBorders(index),
      ),
      child: Center(
        child: Text(
          '$index',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

BoxBorder _getBorders(int index) {
  if (index == 1) {
    return const Border(
      left: BorderSide(
        width: 3,
        color: AppColors.yellowLight,
      ),
      right: BorderSide(
        width: 1,
        color: AppColors.yellowLight,
      ),
      top: BorderSide(
        width: 3,
        color: AppColors.yellowLight,
      ),
      bottom: BorderSide(
        width: 3,
        color: AppColors.yellowLight,
      ),
    );
  } else if (index == 10) {
    return const Border(
      left: BorderSide(
        width: 1,
        color: AppColors.yellowLight,
      ),
      right: BorderSide(
        width: 3,
        color: AppColors.yellowLight,
      ),
      top: BorderSide(
        width: 3,
        color: AppColors.yellowLight,
      ),
      bottom: BorderSide(
        width: 3,
        color: AppColors.yellowLight,
      ),
    );
  } else {
    return const Border(
      left: BorderSide(
        width: 1,
        color: AppColors.yellowLight,
      ),
      right: BorderSide(
        width: 1,
        color: AppColors.yellowLight,
      ),
      top: BorderSide(
        width: 3,
        color: AppColors.yellowLight,
      ),
      bottom: BorderSide(
        width: 3,
        color: AppColors.yellowLight,
      ),
    );
  }
}
