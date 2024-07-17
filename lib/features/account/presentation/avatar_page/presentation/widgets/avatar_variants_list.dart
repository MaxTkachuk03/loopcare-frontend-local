import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/cards/custom_tappable_card.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_controller.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_lists.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_type_key.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_variant_option.dart';

class AvatarVariantsList extends StatelessWidget {
  final AvatarController controller;

  const AvatarVariantsList({super.key, required this.controller});

  List<AvatarVariantOption> get _avatarVariantsList =>
      switch (controller.selectedAvatarOption.value?.type) {
        AvatarTypeKey.icon => AvatarLists.iconAvatarVariantsList,
        AvatarTypeKey.iconFemale => AvatarLists.femaleIconAvatarVariantsList,
        AvatarTypeKey.iconMale => AvatarLists.maleIconAvatarVariantsList,
        AvatarTypeKey.photo => AvatarLists.iconAvatarVariantsList,
        null => AvatarLists.iconAvatarVariantsList,
      };

  void _onVariantItemPressed(AvatarVariantOption item) => controller
    ..changeShowAvatarVariations(false)
    ..changeAvatar(item);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      child: CustomTappableCard(
        child: ValueListenableBuilder(
          valueListenable: controller.selectedAvatarOption,
          builder: (context, options, _) {
            return ListView.separated(
              itemCount: _avatarVariantsList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                final item = _avatarVariantsList[i];

                return GestureDetector(
                    onTap: () => _onVariantItemPressed(item),
                    child: CircleAvatar(radius: 22, child: item.image));
              },
              separatorBuilder: (_, __) =>
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 12)),
            );
          },
        ),
      ),
    );
  }
}
