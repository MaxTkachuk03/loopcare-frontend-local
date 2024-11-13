import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/avatar_container.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_controller.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_variant_option.dart';

const double _avatarSize = 150.0;

class LocalUserAvatar extends StatelessWidget {
  final AvatarController controller;
  final void Function()? onPressed;

  const LocalUserAvatar({super.key, required this.controller, required this.onPressed});

  Widget _getChildIcon(AvatarVariantOption? avatar, File? photo) {
    if (photo == null) {
      final imagePath = avatar?.imagePath ?? AppIcons.avatarIconPhotoPath;
      return SvgPicture.asset(
        imagePath,
        width: _avatarSize,
        height: _avatarSize,
      );
    } else {
      return const SizedBox.shrink();
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
          builder: (_, photo, __) => AvatarContainer(
            child: CircleAvatar(
              foregroundImage: photo != null ? FileImage(photo) : null,
              radius: _avatarSize / 2,
              child: _getChildIcon(avatar, photo),
            ),
          ),
        ),
      ),
    );
  }
}
