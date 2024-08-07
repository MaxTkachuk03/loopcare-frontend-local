import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/image_helper/image_helper.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_option.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_variant_option.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/user_avatar_mode.dart';
import 'package:permission_handler/permission_handler.dart';

class AvatarController {
  final ImageHelper _imageHelper;
  AvatarController(this._imageHelper);

  ValueNotifier<bool> showAvatarMenu = ValueNotifier(false);
  ValueNotifier<bool> canSave = ValueNotifier(false);
  ValueNotifier<AvatarOption?> selectedAvatarOption = ValueNotifier(null);
  ValueNotifier<AvatarVariantOption?> selectedAvatar = ValueNotifier(null);
  ValueNotifier<File?> selectedPhoto = ValueNotifier(null);
  ValueNotifier<UserAvatarMode> avatarMode = ValueNotifier(const UserAvatarMode.local());
  ValueNotifier<bool> showSizeError = ValueNotifier(false);
  ValueNotifier<bool> showPermissionsPopup = ValueNotifier(false);

  void onSelectAvatarOption(AvatarOption item) => selectedAvatarOption.value = item;

  void setAvatarMode(UserAvatarMode mode) => avatarMode.value = mode;

  void changeShowAvatarMenu(bool val) => showAvatarMenu.value = val;

  void setCanSave() => canSave.value = selectedAvatar.value != null || selectedPhoto.value != null;

  void changeAvatar(AvatarVariantOption val) {
    selectedAvatar.value = val;
    selectedPhoto.value = null;
    avatarMode.value = const UserAvatarMode.local();
    setCanSave();
  }

  void onPickPhoto() async {
    PermissionStatus status =
        Platform.isAndroid ? await Permission.camera.status : await Permission.photos.status;

    if (status.isDenied) {
      status = Platform.isAndroid
          ? await Permission.camera.request()
          : await Permission.photos.request();
    }

    if (status.isPermanentlyDenied) {
      showPermissionsPopup.value = true;
    }

    if (status.isGranted || status.isLimited) {
      final file = await _imageHelper.pickImage();

      if (file != null) {
        final croppedImage = await _imageHelper.crop(file: file);

        if (croppedImage != null) {
          final croppedFile = File(croppedImage.path);
          if (await croppedFile.length() > Constants.avatarFileMaxSize) {
            showSizeError.value = true;
            return;
          }
          selectedAvatar.value = null;
          selectedPhoto.value = croppedFile;
          avatarMode.value = const UserAvatarMode.local();
          setCanSave();
        }
      }
    }
  }

  dispose() {
    showAvatarMenu.dispose();
    canSave.dispose();
    selectedAvatarOption.dispose();
    selectedAvatar.dispose();
    selectedPhoto.dispose();
    avatarMode.dispose();
    showSizeError.dispose();
    showPermissionsPopup.dispose();
  }
}
