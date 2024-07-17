import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AccountContainer extends StatelessWidget {
  final Widget child;

  const AccountContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.blueLightest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 34.0),
        child: child,
      ),
    );
  }
}
