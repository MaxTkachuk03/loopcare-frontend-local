import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';

class NetworkUserAvatar extends StatelessWidget {
  final String url;
  final void Function()? onPressed;

  const NetworkUserAvatar({super.key, this.onPressed, required this.url});

  get _isSvg => url.contains('svg');

  get _content {
    if (url.isEmpty) {
      return SvgPicture.asset(
        '${AppIcons.iconsFilePath}/user_avatar_icon_photo.svg',
        width: 150,
        height: 150,
      );
    } else if (_isSvg) {
      return CircleAvatar(radius: 75, child: SvgPicture.network(url, width: 150, height: 150));
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(150.0),
        child: SizedBox(
            width: 150,
            height: 150,
            child: NetworkImageWithCache(url: url, imageBoxFit: BoxFit.cover)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onPressed, child: _content);
  }
}
