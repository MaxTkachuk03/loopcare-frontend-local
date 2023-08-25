import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SessionVideoContainer extends StatelessWidget {
  const SessionVideoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.black,
      child: Text('full screen container'),
    );
  }
}
