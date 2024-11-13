import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';

class SubscriptionImage extends StatelessWidget {
  final String url;

  const SubscriptionImage({
    super.key,
    String? url,
  }) : url = url ?? '';

  bool get _isSvg => url.contains('svg');

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const SizedBox.shrink();
    } else if (_isSvg) {
      return SvgPicture.network(url);
    }
    return NetworkImageWithCache(url: url, imageBoxFit: BoxFit.fill);
  }
}
