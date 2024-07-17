import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_controller.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_lists.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_option.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_type_key.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/presentation/widgets/avatars_list_item.dart';

class AvatarsList extends StatelessWidget {
  final AvatarController controller;

  const AvatarsList({super.key, required this.controller});

  void _onAvatarPresedHandler(AvatarOption item) async {
    if (item.type == AvatarTypeKey.photo) {
      controller.onPickPhoto();
    } else {
      controller
        ..changeShowAvatarVariations(true)
        ..onSelectAvatarOption(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: AvatarLists.avatarListOptions
              .map(
                (item) => ValueListenableBuilder(
                  valueListenable: controller.selectedAvatarOption,
                  builder: (context, option, _) => AvatarsListItem(
                    item: item,
                    onPressed: _onAvatarPresedHandler,
                    isSelected: option?.type == item.type,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
