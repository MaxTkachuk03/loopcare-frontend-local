import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/local_user_avatar.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/network_user_avatar.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_controller.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

class UserAvatar extends StatelessWidget {
  final AvatarController controller;
  final void Function()? onPressed;

  const UserAvatar({super.key, this.onPressed, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.avatarMode,
      builder: (context, mode, _) => mode.map(
        local: (_) => LocalUserAvatar(
          controller: controller,
          onPressed: onPressed,
        ),
        network: (_) => NetworkUserAvatar(
          url: context.read<AuthenticationBloc>().state.data.avatar,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
