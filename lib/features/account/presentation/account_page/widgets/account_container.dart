import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const paddingDefault = EdgeInsets.symmetric(horizontal: 26.0, vertical: 34.0);

class AccountContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const AccountContainer({
    super.key,
    required this.child,
    this.padding = paddingDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.blueLightest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
