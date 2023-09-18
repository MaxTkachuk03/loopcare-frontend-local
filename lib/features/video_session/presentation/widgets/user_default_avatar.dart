import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class UserDefaultAvatar extends StatelessWidget {
  const UserDefaultAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      child: Center(
        child: AppIcons.sessionUserDefaultAvatar,
      ),
    );
  }
}
