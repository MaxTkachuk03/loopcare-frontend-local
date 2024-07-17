import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_option.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_type_key.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_variant_option.dart';

class AvatarLists {
  AvatarLists._();

  static final avatarListOptions = [
    AvatarOption('photo', AppIcons.userAvatarIconBlue, AvatarTypeKey.photo),
    AvatarOption('avatar 1', AppIcons.userAvatarIconGreen, AvatarTypeKey.icon),
    AvatarOption('avatar 2', AppIcons.femaleAvatarTone1, AvatarTypeKey.iconFemale),
    AvatarOption('avatar 3', AppIcons.maleAvatarTone1, AvatarTypeKey.iconMale),
  ];

  static final iconAvatarVariantsList = [
    AvatarVariantOption(AppIcons.userAvatarIconBlue, AvatarTypeKey.icon),
    AvatarVariantOption(AppIcons.userAvatarIconGreen, AvatarTypeKey.icon),
    AvatarVariantOption(AppIcons.userAvatarIconCoral, AvatarTypeKey.icon),
    AvatarVariantOption(AppIcons.userAvatarIconOrange, AvatarTypeKey.icon),
    AvatarVariantOption(AppIcons.userAvatarIconPetrol, AvatarTypeKey.icon),
    AvatarVariantOption(AppIcons.userAvatarIconYellow, AvatarTypeKey.icon),
  ];

  static final femaleIconAvatarVariantsList = [
    AvatarVariantOption(AppIcons.femaleAvatarTone1, AvatarTypeKey.iconFemale),
    AvatarVariantOption(AppIcons.femaleAvatarTone2, AvatarTypeKey.iconFemale),
    AvatarVariantOption(AppIcons.femaleAvatarTone3, AvatarTypeKey.iconFemale),
    AvatarVariantOption(AppIcons.femaleAvatarTone4, AvatarTypeKey.iconFemale),
  ];

  static final maleIconAvatarVariantsList = [
    AvatarVariantOption(AppIcons.maleAvatarTone1, AvatarTypeKey.iconMale),
    AvatarVariantOption(AppIcons.maleAvatarTone2, AvatarTypeKey.iconMale),
    AvatarVariantOption(AppIcons.maleAvatarTone3, AvatarTypeKey.iconMale),
    AvatarVariantOption(AppIcons.maleAvatarTone4, AvatarTypeKey.iconMale),
  ];
}
