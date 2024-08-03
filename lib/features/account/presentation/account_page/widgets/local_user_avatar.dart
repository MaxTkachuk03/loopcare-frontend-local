import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_controller.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_variant_option.dart';

class LocalUserAvatar extends StatelessWidget {
  final AvatarController controller;
  final void Function()? onPressed;

  const LocalUserAvatar({super.key, required this.controller, required this.onPressed});

  _getChildIcon(AvatarVariantOption? avatar, photo) {
    if (avatar == null && photo == null) {
      return SvgPicture.asset(
        '${AppIcons.iconsFilePath}/user_avatar_icon_photo.svg',
        width: 150,
        height: 150,
      );
    } else if (avatar != null) {
      return SvgPicture.asset(avatar.imagePath, width: 150, height: 150);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ValueListenableBuilder(
        valueListenable: controller.selectedAvatar,
        builder: (_, avatar, __) => ValueListenableBuilder(
          valueListenable: controller.selectedPhoto,
          builder: (_, photo, __) => CircleAvatar(
            foregroundImage: photo != null ? FileImage(photo) : null,
            radius: 75,
            child: _getChildIcon(avatar, photo),
          ),
        ),
      ),
    );
  }
}
