import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/image_helper/image_helper.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_option.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_variant_option.dart';

class AvatarController {
  final ImageHelper _imageHelper;
  AvatarController(this._imageHelper);

  ValueNotifier<bool> showAvatarVariations = ValueNotifier(false);
  ValueNotifier<AvatarOption?> selectedAvatarOption = ValueNotifier(null);
  ValueNotifier<AvatarVariantOption?> selectedAvatar = ValueNotifier(null);
  ValueNotifier<File?> selectedPhoto = ValueNotifier(null);

  void onSelectAvatarOption(AvatarOption item) => selectedAvatarOption.value = item;

  void changeShowAvatarVariations(bool val) => showAvatarVariations.value = val;

  void changeAvatar(AvatarVariantOption val) {
    selectedAvatar.value = val;
    selectedPhoto.value = null;
  }

  void onPickPhoto() async {
    final file = await _imageHelper.pickImage();
    if (file != null) {
      final croppedImage = await _imageHelper.crop(file: file);

      if (croppedImage != null) {
        selectedAvatar.value = null;
        selectedPhoto.value = File(croppedImage.path);
      }
    }
  }

  dispose() {
    showAvatarVariations.dispose();
    selectedAvatarOption.dispose();
    selectedAvatar.dispose();
    selectedPhoto.dispose();
  }
}
