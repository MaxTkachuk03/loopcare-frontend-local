import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_variant_option.dart';

class UserAvatar extends StatelessWidget {
  final AvatarVariantOption? avatar;
  final File? photo;
  final void Function()? onPressed;

  const UserAvatar({super.key, this.avatar, this.onPressed, this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
          foregroundImage: photo != null ? FileImage(photo!) : null,
          radius: 75,
          child: avatar?.image),
    );
  }
}
