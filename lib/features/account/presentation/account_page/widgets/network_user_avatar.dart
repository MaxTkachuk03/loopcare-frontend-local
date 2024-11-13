import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/avatar_container.dart';

const double _avatarSize = 150.0;

const _defaultAvatar = SvgPicture(
  SvgAssetLoader(AppIcons.avatarIconPhotoPath),
  width: _avatarSize,
  height: _avatarSize,
);

class NetworkUserAvatar extends StatelessWidget {
  final String url;
  final void Function()? onPressed;
  final double size;
  final Widget? unselectedAvatar;
  final BorderSide? borderSide;
  final bool _onlyPhotoBorder;

  const NetworkUserAvatar({
    super.key,
    required this.url,
    this.size = _avatarSize,
    this.unselectedAvatar,
    this.borderSide,
    this.onPressed,
  }) : _onlyPhotoBorder = false;

  const NetworkUserAvatar.onlyPhotoBorder({
    super.key,
    required this.url,
    this.size = _avatarSize,
    this.unselectedAvatar,
    this.borderSide,
    this.onPressed,
  }) : _onlyPhotoBorder = true;

  bool get _isSvg => url.contains('svg');

  Widget get _content {
    if (url.isEmpty) {
      return unselectedAvatar ?? _defaultAvatar;
    } else if (_isSvg) {
      return SvgPicture.network(
        url,
        width: size,
        height: size,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: SizedBox(
          width: size,
          height: size,
          child: NetworkImageWithCache(
            url: url,
            imageBoxFit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  bool get _isEditable => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final avatarBorderSide = _onlyPhotoBorder
        ? BorderSide(
            width: 2, color: _isSvg ? AppColors.transparent : AppColors.white, strokeAlign: 1)
        : borderSide;

    final padding = _onlyPhotoBorder && !_isSvg ? 2.0 : 0.0;
    final radius = size / 2 - padding;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(padding),
          child: AvatarContainer(
            radius: radius,
            borderSide: avatarBorderSide,
            child: _content,
          ),
        ),
        if (_isEditable)
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomFilledIconButton(
              onPressed: onPressed,
              styles: IconButton.styleFrom(backgroundColor: AppColors.blueOffRegular),
              iconSize: 18,
              icon: const Icon(Icons.edit, color: AppColors.white),
            ),
          ),
      ],
    );
  }
}
