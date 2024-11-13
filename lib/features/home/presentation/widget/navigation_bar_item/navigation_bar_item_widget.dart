import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/network_user_avatar.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/navigation_bar_item/navigation_bar_items.dart';

const double _iconSize = 24.0;

class NavigationBarItemWidget extends StatelessWidget {
  const NavigationBarItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
  });

  final NavigationBarItems item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ? 1.0 : 0.5,
      child: Builder(
        builder: (context) {
          if (item.isProfile) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) => NetworkUserAvatar.onlyPhotoBorder(
                url: state.data.avatar,
                size: _iconSize,
                unselectedAvatar: SvgPicture.asset(
                  AppIcons.avatarIconBluePath,
                  width: _iconSize,
                  height: _iconSize,
                ),
              ),
            );
          } else if (item.isPractice) {
            return AppIcons.navigationBarPractice;
          } else {
            return AppIcons.navigationBarRiver;
          }
        },
      ),
    );
  }
}
