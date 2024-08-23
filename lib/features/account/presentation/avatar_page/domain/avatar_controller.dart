import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/image_helper/image_helper.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_option.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_variant_option.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/user_avatar_mode.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class AvatarController {
  final ImageHelper _imageHelper;
  final RiverBloc riverBloc;

  AvatarController(this._imageHelper, {required this.riverBloc});

  ValueNotifier<bool> showAvatarMenu = ValueNotifier(false);
  ValueNotifier<bool> canSave = ValueNotifier(false);
  ValueNotifier<AvatarOption?> selectedAvatarOption = ValueNotifier(null);
  ValueNotifier<AvatarVariantOption?> selectedAvatar = ValueNotifier(null);
  ValueNotifier<File?> selectedPhoto = ValueNotifier(null);
  ValueNotifier<UserAvatarMode> avatarMode = ValueNotifier(const UserAvatarMode.local());
  ValueNotifier<bool> showSizeError = ValueNotifier(false);
  ValueNotifier<bool> showPermissionsPopup = ValueNotifier(false);
  ValueNotifier<bool> pickingImageInProgress = ValueNotifier(false);

  Future<List<Permission>> _getAndroidPermissions() async {
    List<Permission> permissions = [Permission.camera];

    final androidInfo = await DeviceInfoPlugin().androidInfo;

    final mediaPermission =
        androidInfo.version.sdkInt <= 32 ? Permission.storage : Permission.photos;

    permissions.add(mediaPermission);

    return permissions;
  }

  Future<List<Permission>> _getIosPermissions() => Future.value([Permission.photos]);

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
    final permissions =
        Platform.isAndroid ? await _getAndroidPermissions() : await _getIosPermissions();

    Map<Permission, PermissionStatus> statuses = await permissions.request();

    if (statuses.containsValue(PermissionStatus.permanentlyDenied)) {
      showPermissionsPopup.value = true;
    }

    if (statuses.values.every(((s) => s.isGranted || s.isLimited))) {
      pickingImageInProgress.value = true;

      final file = await _imageHelper.pickImage();

      if (file != null) {
        final croppedImage = await _imageHelper.crop(file: file);

        if (croppedImage != null) {
          final croppedFile = File(croppedImage.path);
          if (await croppedFile.length() > Constants.avatarFileMaxSize) {
            showSizeError.value = true;
            pickingImageInProgress.value = false;
            return;
          }
          selectedAvatar.value = null;
          selectedPhoto.value = croppedFile;
          avatarMode.value = const UserAvatarMode.local();
          pickingImageInProgress.value = false;
          setCanSave();
        }

        pickingImageInProgress.value = false;
      }

      pickingImageInProgress.value = false;
    }
  }

  void finishRiverModuleItem({bool complete = false}) {
    riverBloc.add(RiverEvent.finishUserAvatarRiverModuleItem(complete: complete));
  }

  void dispose() {
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
