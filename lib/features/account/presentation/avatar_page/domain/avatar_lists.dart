import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_option.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_type_key.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_variant_option.dart';

class AvatarLists {
  AvatarLists._();

  static final avatarListOptions = [
    AvatarOption('photo', AppIcons.userAvatarIconPhoto, AvatarTypeKey.photo),
    AvatarOption('avatar 1', AppIcons.userAvatarIconGreen, AvatarTypeKey.icon),
    AvatarOption('avatar 2', AppIcons.femaleAvatarTone1, AvatarTypeKey.iconFemale),
    AvatarOption('avatar 3', AppIcons.maleAvatarTone1, AvatarTypeKey.iconMale),
  ];

  static final iconAvatarVariantsList = [
    AvatarVariantOption('${AppIcons.iconsFilePath}/user_avatar_icon_blue.svg', AvatarTypeKey.icon),
    AvatarVariantOption('${AppIcons.iconsFilePath}/user_avatar_icon_green.svg', AvatarTypeKey.icon),
    AvatarVariantOption('${AppIcons.iconsFilePath}/user_avatar_icon_coral.svg', AvatarTypeKey.icon),
    AvatarVariantOption(
        '${AppIcons.iconsFilePath}/user_avatar_icon_orange.svg', AvatarTypeKey.icon),
    AvatarVariantOption(
        '${AppIcons.iconsFilePath}/user_avatar_icon_petrol.svg', AvatarTypeKey.icon),
    AvatarVariantOption(
        '${AppIcons.iconsFilePath}/user_avatar_icon_yellow.svg', AvatarTypeKey.icon),
  ];

  static final femaleIconAvatarVariantsList = [
    AvatarVariantOption(
        '${AppIcons.iconsFilePath}/female_avatar_tone1.svg', AvatarTypeKey.iconFemale),
    AvatarVariantOption(
        '${AppIcons.iconsFilePath}/female_avatar_tone2.svg', AvatarTypeKey.iconFemale),
    AvatarVariantOption(
        '${AppIcons.iconsFilePath}/female_avatar_tone3.svg', AvatarTypeKey.iconFemale),
    AvatarVariantOption(
        '${AppIcons.iconsFilePath}/female_avatar_tone4.svg', AvatarTypeKey.iconFemale),
  ];

  static final maleIconAvatarVariantsList = [
    AvatarVariantOption('${AppIcons.iconsFilePath}/male_avatar_tone1.svg', AvatarTypeKey.iconMale),
    AvatarVariantOption('${AppIcons.iconsFilePath}/male_avatar_tone2.svg', AvatarTypeKey.iconMale),
    AvatarVariantOption('${AppIcons.iconsFilePath}/male_avatar_tone3.svg', AvatarTypeKey.iconMale),
    AvatarVariantOption('${AppIcons.iconsFilePath}/male_avatar_tone4.svg', AvatarTypeKey.iconMale),
  ];
}
