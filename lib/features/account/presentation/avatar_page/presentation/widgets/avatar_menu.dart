import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/avatar_container.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_controller.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_lists.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_type_key.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_variant_option.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class AvatarMenu extends StatelessWidget {
  final AvatarController controller;

  const AvatarMenu({super.key, required this.controller});

  List<AvatarVariantOption> get _avatarVariantsList =>
      switch (controller.selectedAvatarOption.value?.type) {
        AvatarTypeKey.icon => AvatarLists.iconAvatarVariantsList,
        AvatarTypeKey.iconFemale => AvatarLists.femaleIconAvatarVariantsList,
        AvatarTypeKey.iconMale => AvatarLists.maleIconAvatarVariantsList,
        AvatarTypeKey.photo => [],
        null => AvatarLists.iconAvatarVariantsList,
      };

  void _onVariantItemPressed(AvatarVariantOption item) => controller.changeAvatar(item);

  void _onAddPhotoPressedHandler() => controller.onPickPhoto();

  bool get _isPhotoSelected => controller.selectedAvatarOption.value?.type == AvatarTypeKey.photo;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.selectedAvatarOption,
      builder: (context, options, _) {
        if (_isPhotoSelected) {
          return CustomOutlinedButton.blueFullWidth(
            label: LocalizedTexts.avatarAddPhoto.tr(),
            onPressed: _onAddPhotoPressedHandler,
          );
        }

        return ValueListenableBuilder(
          valueListenable: controller.selectedAvatar,
          builder: (_, avatar, __) => SizedBox(
            height: 66,
            child: Card(
              elevation: 2,
              child: ListView.builder(
                itemCount: _avatarVariantsList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  final item = _avatarVariantsList[i];
                  final isSelected = item == avatar;

                  return Material(
                    color: isSelected ? AppColors.blueLightest : AppColors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => _onVariantItemPressed(item),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: AvatarContainer(
                          radius: 22,
                          child: SvgPicture.asset(item.imagePath),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
