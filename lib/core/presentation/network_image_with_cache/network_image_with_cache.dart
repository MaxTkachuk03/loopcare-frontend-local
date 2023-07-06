import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/injection.dart';

class NetworkImageWithCache extends StatelessWidget {
  final String url;
  final BoxFit? imageBoxFit;
  final Alignment? alignment;
  final bool withPlaceholder;

  const NetworkImageWithCache({
    Key? key,
    required this.url,
    this.imageBoxFit,
    this.alignment,
    this.withPlaceholder = true,
  }) : super(key: key);

  _getAuthToken() {
    final authManager = getIt<AuthTokenManager>();
    return authManager.getAccessToken();
  }

  Future _deleteImageFromCache(String url) {
    return CachedNetworkImage.evictFromCache(url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAuthToken(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return CachedNetworkImage(
            imageUrl: url,
            cacheKey: url,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: imageBoxFit ?? BoxFit.fitHeight,
                  alignment: alignment ?? Alignment.center,
                ),
              ),
            ),
            httpHeaders: {
              "Authorization": 'Bearer ${snapshot.data}',
            },
            placeholder: (context, url) {
              if (withPlaceholder) return const Loader();
              return const SizedBox.shrink();
            },
            errorWidget: (context, url, error) {
              _deleteImageFromCache(url);
              return const Icon(Icons.error);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
