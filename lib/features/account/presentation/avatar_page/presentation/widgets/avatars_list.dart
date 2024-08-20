import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_controller.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_lists.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_option.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/presentation/widgets/avatars_list_item.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

class AvatarsList extends StatelessWidget {
  final AvatarController controller;

  const AvatarsList({super.key, required this.controller});

  void _onAvatarPresedHandler(AvatarOption item) => controller
    ..changeShowAvatarMenu(true)
    ..onSelectAvatarOption(item);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final isLoading = state is AuthenticationStateIsLoading;

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
                        isDisabled: isLoading,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
